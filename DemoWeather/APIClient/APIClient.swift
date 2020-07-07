//
//  APIClient.swift
//  DemoWeather
//
//  Created by admin on 03/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

// MARK: - CustomError

enum CustomError: Error, LocalizedError {
  
  case networking(code: Int, message: String)
  case unknown
  
  public var errorDescription: String? {
    switch self {
    case .networking( _, let message):
      return message
      
    case .unknown:
      return "Unknown"
    }
  }
}

// MARK: - Enum

enum RestMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

// MARK: - APIProtocol

protocol APIClientProtocol {
  var baseURL: URL { get }
  var session: URLSession { get }
  var defaultHeaders: [String: String] { get }
  
  func get<D: Decodable>(responseType: D.Type,
                         urlPath: String,
                         parameters: [String : String]?,
                         completion: @escaping (D?, URLResponse?, Error?) -> Void)
  
  func post<E: Encodable, D: Decodable>(responseType: D.Type,
                                        urlPath: String,
                                        parameters: [String : String]?,
                                        body: E?,
                                        completion: @escaping (D?, URLResponse?, Error?) -> Void)
  func performRequest<D: Decodable>(responseType: D.Type,
                                    request: URLRequest,
                                    completion: @escaping (D?, URLResponse?, Error?) -> Void)
}

// MARK: - APIClient

class APIClient {
  
  fileprivate struct API {
    static let errorKey: String = "error"
  }
  
  let baseURL: URL
  let session: URLSession
  var defaultHeaders: [String : String]
  fileprivate var cachedResponse: [String: Decodable] = [:]
  
  init(baseUrlString: String) {
    let url = URL.init(string: baseUrlString)
    guard let baseURL = url else {
      print("API Client not initialized")
      fatalError()
    }
    self.baseURL = baseURL
    self.session = URLSession(configuration: URLSessionConfiguration.default)
    self.defaultHeaders = ["Accept": "application/json"]
  }
  
  func configureDefaultHeader() -> [String: String] {
    // Here We can set auth key, api version info, platform specific
    return ["Accept": "application/json"]
  }
}

// MARK: - APIClientProtocol Implementation

extension APIClient: APIClientProtocol {
  
  func get<D: Decodable>(responseType: D.Type,
                         urlPath: String,
                         parameters: [String : String]?,
                         completion: @escaping (D?, URLResponse?, Error?) -> Void) {
    guard let url = UrlBuilder.init(url: baseURL)
      .set(path: urlPath)
      .addParams(params: parameters)
      .build() else {
        return
    }
    
    let request = buildRequest(url: url,
                               method: RestMethod.get.rawValue,
                               headers: defaultHeaders,
                               body: Optional<String>.none)
    performRequest(responseType: responseType,
                   request: request,
                   completion: completion)
  }
  
  func post<E: Encodable, D: Decodable>(responseType: D.Type,
                                        urlPath: String,
                                        parameters: [String : String]?,
                                        body: E?,
                                        completion: @escaping (D?, URLResponse?, Error?) -> Void) {
    let url = baseURL.appendingPathComponent(urlPath).addParams(params: parameters)
    let request = buildRequest(url: url,
                               method: RestMethod.post.rawValue,
                               headers: defaultHeaders,
                               body: body)
    performRequest(responseType: responseType,
                   request: request,
                   completion: completion)
  }
  
  
  func performRequest<D: Decodable>(responseType: D.Type,
                                    request: URLRequest,
                                    completion: @escaping (D?, URLResponse?, Error?) -> Void) {
    self.session.dataTask(with: request) { [weak self] (data, response, error) in
      guard let strongSelf = self else {
        return
      }
      
      guard let urlResponse = response as? HTTPURLResponse else {
        fatalError("Request is not HTTP request")
      }
      
      switch(urlResponse.status.responseType) {
        
      case .success:
        return strongSelf.handleSuccess(response: urlResponse, data: data, completion: completion)
      case .clientError:
        let errorMessage = strongSelf.getErrorMessage(data: data) ?? "client Error"
        let customError = CustomError.networking(code: urlResponse.statusCode, message: errorMessage)
        DispatchQueue.main.async {
          completion(nil, urlResponse, customError)
        }
      case .serverError:
        let errorMessage = strongSelf.getErrorMessage(data: data) ?? "server Error"
        let customError = CustomError.networking(code: urlResponse.statusCode, message: errorMessage)
        DispatchQueue.main.async {
          completion(nil, urlResponse, customError)
        }
      case .undefined:
        let customError = CustomError.unknown
        DispatchQueue.main.async {
          completion(nil, urlResponse, customError)
        }
      }
      
      }.resume()
  }
  
  fileprivate func getErrorMessage(data: Data?) -> String? {
    guard let responseData = data else {
      return nil
    }
    
    do {
      guard let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any],
        let errorMessage = json[API.errorKey] as? String else {
          return nil
      }
      return errorMessage
    }
    catch {
      return nil
    }
  }
  
  fileprivate func handleSuccess<D: Decodable>(response: HTTPURLResponse,
                                               data: Data?,
                                               completion: @escaping (D?, URLResponse?, Error?) -> Void) {
    guard let responseData = data else {
      DispatchQueue.main.async {
        completion(nil, response, CustomError.unknown)
      }
      return
    }
    
    let decoder = NormalizingDecoder()
  
    //decoder.dateDecodingStrategy = .formatted(dateFormatter)
   // decoder.dateDecodingStrategy = .millisecondsSince1970
    
    do {
      let result = try decoder.decode(D.self, from: responseData)
      DispatchQueue.main.async {
        completion(result, response, nil)
      }
    } catch let parsingError  {
      DispatchQueue.main.async {
        completion(nil, response, parsingError)
      }
    }
  }
  
  // We can use factory/ builder pattern to build complex request
  private func buildRequest<E: Encodable>(url: URL,
                                          method: String,
                                          headers: [String: String]?,
                                          body: E?) -> URLRequest {
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = method
    if let requestHeaders = headers {
      for (key, value) in requestHeaders {
        request.addValue(value, forHTTPHeaderField: key)
      }
    }
    if let requestBody = body {
      let encoder = JSONEncoder();
      request.httpBody = try? encoder.encode(requestBody)
    }
    return request
  }
  
}

// MARK: - Extensions

fileprivate extension URL {
  func addParams(params: [String: String]?) -> URL {
    guard let params = params else {
      return self
    }
    var urlComp = URLComponents(url: self, resolvingAgainstBaseURL: true)!
    var queryItems = [URLQueryItem]()
    for (key, value) in params {
      queryItems.append(URLQueryItem(name: key, value: value))
    }
    urlComp.queryItems = queryItems
    return urlComp.url!
  }
}

class NormalizingDecoder: JSONDecoder {

   
    lazy var dateFormatter: DateFormatter  = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df
    }()
    
    let calendar = Calendar.current

    override init() {
        super.init()
       // self.dateFormatter = DateFormatter()
        //self.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        dateDecodingStrategy = .custom { (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            let date = self.dateFormatter.date(from: dateString)

            return date ?? Date()
        }
    }
}

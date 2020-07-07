//
//  WeatherAPIService.swift
//  DemoWeather
//
//  Created by admin on 06/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

typealias FetchWeatherInfoUseCaseCompletionHandler = (WeatherInfo?, _ error: Error?) -> Void
typealias FetchForecastWeatherInfoUseCaseCompletionHandler = (ForecastInfoResponse?, _ error: Error?) -> Void

protocol FetchCityWeatherProtocol {
  func fetchWeatherInfo(forCity city: String,
                     completion: @escaping FetchWeatherInfoUseCaseCompletionHandler)
}

protocol FetchLocationWeatherProtocol {
    func fetchWeatherInfo(forLocation lat: Double, long: Double,
  completion: @escaping FetchForecastWeatherInfoUseCaseCompletionHandler)
}


// It will be aggregation of all GitRepoAPI protocols

typealias WeatherApiServiceProtocol = FetchLocationWeatherProtocol & FetchCityWeatherProtocol


// We can use facade here by having different dependencies other than API Client like local data saving

final class WeatherApiService: WeatherApiServiceProtocol {
 
  //http://api.openweathermap.org/data/2.5/weather?
  fileprivate struct Defaults {
    static let urlString: String = "https://api.openweathermap.org"
    static let weatherPath: String = "/data/2.5/weather"
    static let forecastPath: String = "/data/2.5/forecast"
    // Not applying any security concern for this key, but we can use Obfuscation or saving as encryption
    static let apiKey: String = "#API_KEY"
    
  }
  
  static let shared = WeatherApiService(apiClient: APIClient(baseUrlString: Defaults.urlString))
  private let apiClient: APIClient
  
  // MARK: - Private Init
  
  private init(apiClient: APIClient) {
    self.apiClient = apiClient
  }
  
  // MARK: - Public Methods
    
    func fetchWeatherInfo(forLocation lat: Double, long: Double, completion: @escaping FetchForecastWeatherInfoUseCaseCompletionHandler) {
         //api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={your api key}
        let parameter: [String: String] = ["lat": lat.description,"lon": long.description, "appid": Defaults.apiKey]
        apiClient.get(responseType: ForecastInfoResponse.self,
                      urlPath: Defaults.forecastPath,
                      parameters: parameter) { (response, urlResponse, error) in
                        completion(response, error)
        }
     }
     
     func fetchWeatherInfo(forCity city: String, completion: @escaping FetchWeatherInfoUseCaseCompletionHandler) {
        //http://api.openweathermap.org/data/2.5/weather?q=new%20york&appid=8fee8b835b47767b3a2660c834d011d6
        
        let parameter: [String: String] = ["q": city, "appid": Defaults.apiKey]
           apiClient.get(responseType: WeatherInfo.self,
                         urlPath: Defaults.weatherPath,
                         parameters: parameter) { (response, urlResponse, error) in
                           completion(response, error)
           }
     }
}

//
//  UrlBuilder.swift
//  DemoWeather
//
//  Created by admin on 03/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class UrlBuilder {
  
  private var components: URLComponents
  
  init() {
    self.components = URLComponents()
  }
  
  convenience init(url: URL) {
    self.init()
    self.components.scheme = url.scheme
    self.components.host = url.host
  }
  
  func set(scheme: String) -> UrlBuilder {
    components.scheme = scheme
    return self
  }
  
  func set(host: String) -> UrlBuilder {
    components.host = host
    return self
  }

  func set(path: String) -> UrlBuilder {
    var path = path
    if !path.hasPrefix("/") {
      path = "/" + path
    }
    components.path = path
    return self
  }
  
  func addParams(params: [String: String]?) -> UrlBuilder {
    guard let params = params else {
      return self
    }
    var queryItems = [URLQueryItem]()
    for (key, value) in params {
      queryItems.append(URLQueryItem(name: key, value: value))
    }
    components.queryItems = queryItems
    return self
  }
  
  func build() -> URL? {
    return components.url
  }
}

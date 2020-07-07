//
//  HTTPURLResponseExtensions.swift
//  DemoWeather
//
//  Created by admin on 03/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
  var status: HTTPStatusCode {
    guard let status = HTTPStatusCode(rawValue: statusCode) else {
      return .undefined
    }
    return status
  }
}

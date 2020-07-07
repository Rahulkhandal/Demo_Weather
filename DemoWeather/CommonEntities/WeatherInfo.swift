//
//  WeatherInfo.swift
//  DemoWeather
//
//  Created by admin on 06/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct TemperatureInfo: Codable {
    let min: Double!
    let max: Double!
    
    private enum CodingKeys: String, CodingKey {
        case min = "temp_min"
        case max = "temp_max"
    }
}

struct WeatherDescription: Codable {
    let description: String!
    let main: String!
    
    private enum CodingKeys: String, CodingKey {
      case main = "main"
        case description = "description"
    }
}

struct WindInfo: Codable {
    let speed: Double!
    private enum CodingKeys: String, CodingKey {
          case speed = "speed"
       }
}

struct WeatherInfo: Codable {
  let temp: TemperatureInfo!
  let weatherDescription: [WeatherDescription]
  let windInfo: WindInfo!
  let dateInfo: Date!
  
  private enum CodingKeys: String, CodingKey {
    case temp = "main"
    case weatherDescription = "weather"
    case windInfo = "wind"
    case dateInfo = "dt_txt"
   
  }
}
/*
struct ForecastInfo: Codable {
    let temp: TemperatureInfo!
    let weatherDescription: [WeatherDescription]
    let windInfo: WindInfo!
    let date: Date!
    
      private enum CodingKeys: String, CodingKey {
        case temp = "main"
        case weatherDescription = "weather"
        case windInfo = "wind"
        case date = "dt_txt"
      }
}
*/

struct ForecastInfoResponse: Codable {
    let forecastList: [WeatherInfo]?
    let count: Int
    
    private enum CodingKeys: String, CodingKey {
        case count = "cnt"
        case forecastList = "list"
    }
}

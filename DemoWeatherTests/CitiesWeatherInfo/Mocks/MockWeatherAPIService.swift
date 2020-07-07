//
//  MockWeatherAPIService.swift
//  DemoWeatherTests
//
//  Created by admin on 07/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
@testable import DemoWeather

final class MockWeatherAPIService: WeatherApiServiceProtocol {
    func fetchWeatherInfo(forLocation lat: Double, long: Double, completion: @escaping FetchForecastWeatherInfoUseCaseCompletionHandler) {
        
    }
    
    
    var doesFetchWeatherInfoForCityCalled = false
    var doesFetchWeatherInfoForLocationCalled = false

    var response: WeatherInfo?
    var error: Error?
    
    
    func fetchWeatherInfo(forCity city: String,
                          completion: @escaping FetchWeatherInfoUseCaseCompletionHandler) {
        doesFetchWeatherInfoForCityCalled = true
        if let response = self.response {
            completion(response, nil)
        }
        else if let error = self.error {
            completion(nil, error )
        }
        else {
            completion(nil, CustomError.unknown)
        }
    }
    
    func fetchWeatherInfo(forLocation lat: Double, long: Double,
                          completion: @escaping FetchWeatherInfoUseCaseCompletionHandler) {
        doesFetchWeatherInfoForLocationCalled = true
      if let response = self.response {
                 completion(response, nil)
             }
             else if let error = self.error {
                 completion(nil, error )
             }
             else {
                 completion(nil, CustomError.unknown)
             }
         }
}


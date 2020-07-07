//
//  MockCitiesWeatherInfoInteractor.swift
//  DemoWeatherTests
//
//  Created by admin on 06/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
@testable import DemoWeather

final class MockCitiesWeatherInfoInteractor: CitiesWeatherInfoInteratorInputProtocol {
  
  // MARK: - Variables
  
  weak var output: CitiesWeatherInfoInteratorOutputProtocol?
  
  var isFetchWeatherInfoListCalled: Bool = false
  var shouldFetchWeatherInfoListReturnResponse: Bool = false
  var response: [WeatherInfo]?
  var cities: [String]?
  
  // MARK: - Public Function
  
    func fetchCitiesWeather(forCities cities: [String]) {
        self.cities = cities
        isFetchWeatherInfoListCalled = true
        if let response = response, shouldFetchWeatherInfoListReturnResponse {
            output?.handleFetchCitiesWeatherSuccess(response: response)
        }
        else {
            output?.handleFetchCitiesWeatherError(error: CustomError.unknown)
        }
    }  
}

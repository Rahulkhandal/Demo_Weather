//
//  MockCitiesWeatherInfoPresenter.swift
//  DemoWeatherTests
//
//  Created by admin on 06/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
@testable import DemoWeather

final class MockCitiesWeatherInfoPresenter: CitiesWeatherInfoPresenter {

  var doesOnViewDidLoadCalled = false
  var doesOnShowWeatherClickCalled = false
  
  var handleSuccessMethodCalled = false
  var handleErrorMethodCalled = false
  var successResponse: [WeatherInfo]?
  var errorResponse: Error?
 
    func onViewDidLoad() {
        doesOnViewDidLoadCalled = true
    }
    
    func onShowWeatherClick(cities: [String]) {
        doesOnShowWeatherClickCalled = true
    }
}

extension MockCitiesWeatherInfoPresenter: CitiesWeatherInfoInteratorOutputProtocol {
  
    func handleFetchCitiesWeatherSuccess(response: [WeatherInfo]) {
        successResponse = response
        handleSuccessMethodCalled = true
        handleErrorMethodCalled = false
    }
    func handleFetchCitiesWeatherError(error: Error) {
        errorResponse = error
        handleErrorMethodCalled = true
        handleSuccessMethodCalled = false
    }

}

//
//  CitiesWeatherInfoInteractor.swift
//  DemoWeather
//
//  Created by admin on 06/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

final class CitiesWeatherInfoInteractorImpl {
  
  // MARK: - Fileprivate Variables
  
  fileprivate weak var output: CitiesWeatherInfoInteratorOutputProtocol?
  fileprivate let apiService: FetchCityWeatherProtocol
  
  // MARK: - Initialization Methods implementation
  
  init(output: CitiesWeatherInfoInteratorOutputProtocol,
       apiService: FetchCityWeatherProtocol) {
    self.output = output
    self.apiService = apiService
  }
}

// MARK: - CitiesWeatherInfoInteratorInputProtocol implementation

extension CitiesWeatherInfoInteractorImpl: CitiesWeatherInfoInteratorInputProtocol {
    func fetchCitiesWeather(forCities cities: [String]) {
        let dispatchGroup = DispatchGroup()
        var weatherInfoCities: [WeatherInfo] = []
        var apiError: Error?
        
        for city in cities {
            dispatchGroup.enter()
        apiService.fetchWeatherInfo(forCity: city) { [weak self] (response, error) in
            
           
            if let response = response {
                weatherInfoCities.append(response)
            }
            else if let error = error {
                apiError = error
            }
            else {
                apiError = CustomError.unknown
            }
            dispatchGroup.leave()
        }
    }
        
        dispatchGroup.notify(queue: .main) {
            self.output?.handleFetchCitiesWeatherSuccess(response: weatherInfoCities)
            if let error = apiError {
                self.output?.handleFetchCitiesWeatherError(error: error)
            }
        }
        
    }
}

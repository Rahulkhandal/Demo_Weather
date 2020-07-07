//
//  CurrentLocationWeatherInfoInteractorImpl.swift
//  DemoWeather
//
//  Created by admin on 07/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

final class CurrentLocationWeatherInfoInteractorImpl {
    
    // MARK: - Fileprivate Variables
    
    fileprivate weak var output: CurrentLocationWeatherInfoInteratorOutputProtocol?
    fileprivate let apiService: FetchLocationWeatherProtocol
    
    // MARK: - Initialization Methods implementation
    
    init(output: CurrentLocationWeatherInfoInteratorOutputProtocol,
         apiService: FetchLocationWeatherProtocol) {
        self.output = output
        self.apiService = apiService
    }
}
// MARK: - CitiesWeatherInfoInteratorInputProtocol implementation

extension CurrentLocationWeatherInfoInteractorImpl: CurrentLocationWeatherInfoInteratorInputProtocol {
    func fetchWeather(forCurrentLocation latitude: Double, longitude: Double) {
        
        apiService.fetchWeatherInfo(forLocation: latitude, long: longitude) { [weak self] (response, error) in
            guard let strongSelf = self else {
                return
            }
            
            if let response = response {
                strongSelf.output?.handleFetchCurrentLocationWeatherSuccess(response: response.forecastList ?? [])
                
                
            }
            else if let error = error {
                strongSelf.output?.handleFetchCurrentLocationWeatherError(error: error)
            }
            else {
                
                strongSelf.output?.handleFetchCurrentLocationWeatherError(error: CustomError.unknown)
            }
        }
    }
}

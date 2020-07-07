//
//  CurrentLocationWeatherInfoPresenterImpl.swift
//  DemoWeather
//
//  Created by admin on 07/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

final class CurrentLocationWeatherInfoPresenterImpl {
  
  // MARK: FilePrivate Variables
  
  fileprivate var weatherInfoList: [WeatherInfo] = []

  fileprivate weak var view: CurrentLocationWeatherInfoView?
  
  // MARK: Internal Variables
  
  var interactor: CurrentLocationWeatherInfoInteratorInputProtocol?
  
    fileprivate var latitude: Double!
    fileprivate var longitude: Double!
  // MARK: - Initialization Methods Implementation
  
  init(view: CurrentLocationWeatherInfoView,
       latitude: Double,
       longitude: Double) {
    self.view = view
    self.latitude = latitude
    self.longitude = longitude
  }
}

// MARK: CitiesWeatherInfoPresenter Implementation

extension CurrentLocationWeatherInfoPresenterImpl: CurrentLocationWeatherInfoPresenter {
    func onViewDidLoad() {
        view?.prepareTableViewAdapter(datasource: [])
        interactor?.fetchWeather(forCurrentLocation: latitude, longitude: longitude)
    }
}

// MARK: CitiesWeatherInfoInteratorOutputProtocol Implementation

extension CurrentLocationWeatherInfoPresenterImpl: CurrentLocationWeatherInfoInteratorOutputProtocol {
    func handleFetchCurrentLocationWeatherSuccess(response: [WeatherInfo]) {
        view?.updateAdapter(datasource: response)
        view?.refreshLayout()
    }
    
    func handleFetchCurrentLocationWeatherError(error: Error) {
        
    }
}

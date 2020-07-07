//
//  CitiesWeatherInfoPresenter.swift
//  DemoWeather
//
//  Created by admin on 06/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

final class CitiesWeatherInfoPresenterImpl {
  
  // MARK: FilePrivate Variables
  
  fileprivate var weatherInfoList: [WeatherInfo] = []
  fileprivate var cities: [String] = []
  fileprivate weak var view: CitiesWeatherInfoView?
  
  // MARK: Internal Variables
  
  var interactor: CitiesWeatherInfoInteratorInputProtocol?
  
  // MARK: - Initialization Methods Implementation
  
  init(view: CitiesWeatherInfoView,
       cities: [String]) {
    self.view = view
    self.cities = cities
  }
}

// MARK: CitiesWeatherInfoPresenter Implementation

extension CitiesWeatherInfoPresenterImpl: CitiesWeatherInfoPresenter {
    func onViewDidLoad() {
        view?.prepareTableViewAdapter(datasource: [])
    }
    
    func onShowWeatherClick(cities: [String]) {
        if cities.count > 7 || cities.isEmpty {
            view?.showAlert(message: "Cities count should be greater than 0 and less than 7")
        }
        else {
            interactor?.fetchCitiesWeather(forCities: cities)
        }
    }
    
  
}

// MARK: CitiesWeatherInfoInteratorOutputProtocol Implementation

extension CitiesWeatherInfoPresenterImpl: CitiesWeatherInfoInteratorOutputProtocol {
    func handleFetchCitiesWeatherSuccess(response: [WeatherInfo]) {
        view?.updateAdapter(datasource: response)
        view?.refreshLayout()
    }
    
    func handleFetchCitiesWeatherError(error: Error) {
        
    }
    
  
}

//
//  CitiesWeatherInfoProtocols.swift
//  DemoWeather
//
//  Created by admin on 06/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

protocol CitiesWeatherInfoConfigurator {
  func configure(_ viewController: CitiesWeatherInfoViewController)
}

//typealias CitiesWeatherInfoView = ToastMessageViewProtocol & LoadingProtocol 

protocol CitiesWeatherInfoPresenter: AnyObject {
  func onViewDidLoad()
  func onShowWeatherClick(cities: [String])
}

protocol CitiesWeatherInfoView: AnyObject {
  func prepareTableViewAdapter(datasource: [WeatherInfo])
  func showAlert(message: String)
  func showHud(message: String?)
  func removeHud()
  func updateAdapter(datasource: [WeatherInfo])
  func refreshLayout()
}

protocol CitiesWeatherInfoInteratorInputProtocol: AnyObject {
  func fetchCitiesWeather(forCities cities: [String])
}

protocol CitiesWeatherInfoInteratorOutputProtocol: AnyObject {
  func handleFetchCitiesWeatherSuccess(response: [WeatherInfo])
  func handleFetchCitiesWeatherError(error: Error)
}

protocol CitiesWeatherInfoRouter {
  
}

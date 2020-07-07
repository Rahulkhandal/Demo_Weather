//
//  CurrentLocationWeatherInfoProtocols.swift
//  DemoWeather
//
//  Created by admin on 07/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

protocol CurrentLocationWeatherInfoConfigurator {
    func configure(_ viewController: CurrentLocationWeatherInfoViewController,
                   latitude: Double,
                   longitude: Double)
}

//typealias CurrentLocationWeatherInfoView = ToastMessageViewProtocol & LoadingProtocol

protocol CurrentLocationWeatherInfoPresenter: AnyObject {
  func onViewDidLoad()
}

protocol CurrentLocationWeatherInfoView: AnyObject {
  func prepareTableViewAdapter(datasource: [WeatherInfo])
  func showAlert(message: String)
  func showHud(message: String?)
  func removeHud()
  func updateAdapter(datasource: [WeatherInfo])
  func refreshLayout()
}

protocol CurrentLocationWeatherInfoInteratorInputProtocol: AnyObject {
  func fetchWeather(forCurrentLocation latitude: Double, longitude: Double)
}

protocol CurrentLocationWeatherInfoInteratorOutputProtocol: AnyObject {
  func handleFetchCurrentLocationWeatherSuccess(response: [WeatherInfo])
  func handleFetchCurrentLocationWeatherError(error: Error)
}

protocol CurrentLocationWeatherInfoRouter {
  
}

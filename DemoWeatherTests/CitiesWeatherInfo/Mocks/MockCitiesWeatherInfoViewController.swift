//
//  MockCitiesWeatherInfoViewController.swift
//  DemoWeatherTests
//
//  Created by admin on 07/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
@testable import DemoWeather

final class MockCitiesWeatherInfoViewController: UIViewController, CitiesWeatherInfoView {
    
    var doesShowAlertCalled = false
    var doesShowHudCalled = false
    var doesRemoveHudCalled = false
    var doesAllViewsInitalized = false
    
    func showAlert(message: String) {
        doesShowAlertCalled = true
    }
    
    func showHud(message: String?) {
        doesShowHudCalled = true
    }
    
    func removeHud() {
        doesRemoveHudCalled = true
    }
    
    func prepareTableViewAdapter(datasource: [WeatherInfo]) {
        doesAllViewsInitalized = true
    }
    
    func updateAdapter(datasource: [WeatherInfo]) {
        
    }
    
    func refreshLayout() {
        
    }
}

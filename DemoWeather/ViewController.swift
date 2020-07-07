//
//  ViewController.swift
//  DemoWeather
//
//  Created by admin on 03/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    fileprivate lazy var locationService: LocationService = {
      return LocationService()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func btnCitiesWeatherTapped() {
        let vc = CitiesWeatherInfoViewController.build()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnGetCurrentLocationForecastTapped() {
        DispatchQueue.main.async { [weak self] in
          self?.setupLocationService()
          self?.startUpdatingLocation()
        }
    }
    // MARK: - Private Methods

    fileprivate func setupLocationService() {
      locationService.delegate = self
      locationService.setupLocationService()
    }

    fileprivate func startUpdatingLocation() {
      locationService.startUpdatingLocation()
    }
    
    fileprivate func openCurrentLocationWeatherDetail(latitude: Double, longitude: Double) {
        let vc = CurrentLocationWeatherInfoViewController.build(latitude: latitude, longitude: longitude)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - LocationServiceDelegate methods Implementation
// MARK: -

extension ViewController: LocationServiceDelegate {

  func locationService(_ locationService: LocationService, didUpdateLocation location: CLLocation) {

    let longitude = NSNumber(value: location.coordinate.longitude)
    let latitude = NSNumber(value: location.coordinate.latitude)
   
    print("location",longitude, latitude)
    openCurrentLocationWeatherDetail(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
  }

  func locationService(_ locationService: LocationService, didFailWithError error: Error) {

  }
}

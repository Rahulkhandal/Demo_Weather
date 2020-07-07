//
//  LocationService.swift
//  DemoWeather
//
//  Created by admin on 07/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
  func locationService(_ locationService: LocationService, didUpdateLocation location: CLLocation)
  func locationService(_ locationService: LocationService, didFailWithError error: Error)
}

final class LocationService: NSObject {

  // MARK: - Private Variables declaration

  fileprivate let locationManager = CLLocationManager()

  // MARK: - Public Variables declaration

  weak var delegate: LocationServiceDelegate?

  // MARK: - Private Methods

  fileprivate func stopUpdatingLocation() {
    locationManager.stopUpdatingLocation()
    locationManager.delegate = nil
    delegate = nil
  }

  // MARK: - Public Methods

  func startUpdatingLocation() {
    if CLLocationManager.locationServicesEnabled() {
      locationManager.startUpdatingLocation()
    }
  }

  func setupLocationService() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
  }
}

// MARK: - CLLocationManagerDelegate
// MARK: -

extension LocationService: CLLocationManagerDelegate {

  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

    switch status {
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .restricted, .denied:
      // No Need to Handle this
      break
    default:
      startUpdatingLocation()
    }
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      delegate?.locationService(self, didUpdateLocation: location)
      stopUpdatingLocation()
    }
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    delegate?.locationService(self, didFailWithError: error)
    stopUpdatingLocation()
  }
}

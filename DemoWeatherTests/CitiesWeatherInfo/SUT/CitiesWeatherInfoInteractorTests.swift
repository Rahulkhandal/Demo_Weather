//
//  CitiesWeatherInfoInteractorTests.swift
//  DemoWeatherTests
//
//  Created by admin on 07/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import XCTest
import UIKit
@testable import DemoWeather

class CitiesWeatherInfoInteractorTests: XCTestCase {

  var mockViewController: MockCitiesWeatherInfoViewController!
  var mockPresenter: MockCitiesWeatherInfoPresenter!
  var mockAPIService: MockWeatherAPIService!
  
  var sut: CitiesWeatherInfoInteractorImpl!
  
    override func setUp() {
      configureSUT()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchCitiesWeather() {
        let cities = ["delhi","new york"]
        sut.fetchCitiesWeather(forCities: cities)
        
        XCTAssert(mockAPIService.doesFetchWeatherInfoForCityCalled)
        
        guard let weatherInfo = getJSONFromStubbedFile() else {
            return
        }
        
        mockAPIService.response = weatherInfo
        mockPresenter.handleSuccessMethodCalled = false
        mockPresenter.handleErrorMethodCalled = false
        sut.fetchCitiesWeather(forCities: cities)

       let exp = expectation(description: "Test after 1 seconds")
       let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
       if result == XCTWaiter.Result.timedOut {
           XCTAssert(mockPresenter.handleSuccessMethodCalled == true, "As we set the response and error is nil")
       } else {
           XCTFail("Delay interrupted")
       }
        
        
        
        mockAPIService.response = nil
        mockAPIService.error = CustomError.unknown
        mockPresenter.handleSuccessMethodCalled = false
        mockPresenter.handleErrorMethodCalled = false
        sut.fetchCitiesWeather(forCities: cities)

        let exp1 = expectation(description: "Test after 1 seconds")
              let result1 = XCTWaiter.wait(for: [exp1], timeout: 1.0)
              if result1 == XCTWaiter.Result.timedOut {
                  XCTAssert(mockPresenter.handleErrorMethodCalled == true)
                    XCTAssert(mockPresenter.handleSuccessMethodCalled == false)
              } else {
                  XCTFail("Delay interrupted")
              }
    }

   
  fileprivate func configureSUT() {
   
    self.mockViewController = MockCitiesWeatherInfoViewController()
    self.mockPresenter = MockCitiesWeatherInfoPresenter()
    self.mockAPIService = MockWeatherAPIService()
    
    self.sut = CitiesWeatherInfoInteractorImpl(output: mockPresenter,
                                  apiService: mockAPIService)
    
  }
  
  fileprivate func getJSONFromStubbedFile() -> WeatherInfo? {
    let decoder = JSONDecoder()
    
    if let path = Bundle(for: type(of: self)).path(forResource: "WeatherInfo", ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        let result = try decoder.decode(WeatherInfo.self, from: data)
        
        return result
      }
      catch let error {
        print(error.localizedDescription)
      }
    }
    return nil
  }
}

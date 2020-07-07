//
//  CitiesWeatherInfoPresenterTests.swift
//  DemoWeatherTests
//
//  Created by admin on 07/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import XCTest
@testable import DemoWeather

class CitiesWeatherInfoPresenterTests: XCTestCase {

  var mockInteractor: MockCitiesWeatherInfoInteractor!
  var mockViewController: MockCitiesWeatherInfoViewController!
  
  
  var sut: CitiesWeatherInfoPresenterImpl!
  
    override func setUp() {
      configureSUT()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
  
 func testOnViewDidLoad() {
    
    sut.onViewDidLoad()
    XCTAssert(mockViewController.doesAllViewsInitalized == true)
 }
 
 func testOnShowWeatherClick() {
     var cities = ["delhi","new york"]
    
    sut.onShowWeatherClick(cities: cities)
    XCTAssert(mockInteractor.isFetchWeatherInfoListCalled == true)
    
    cities = []
    mockInteractor.isFetchWeatherInfoListCalled = false
    sut.onShowWeatherClick(cities: cities)
    XCTAssert(mockInteractor.isFetchWeatherInfoListCalled == false)
    XCTAssert(mockViewController.doesShowAlertCalled == true)
    
    cities = ["delhi","new york","delhi","new york", "delhi","new york", "delhi","new york"]
    mockInteractor.isFetchWeatherInfoListCalled = false
    sut.onShowWeatherClick(cities: cities)
    XCTAssert(mockInteractor.isFetchWeatherInfoListCalled == false)
    XCTAssert(mockViewController.doesShowAlertCalled == true)
 }

    
  fileprivate func configureSUT() {
    self.mockInteractor = MockCitiesWeatherInfoInteractor()
    self.mockViewController = MockCitiesWeatherInfoViewController()
    
    self.sut = CitiesWeatherInfoPresenterImpl(view: self.mockViewController,
                                              cities: [])
    self.sut.interactor = mockInteractor
    mockInteractor.output = sut
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

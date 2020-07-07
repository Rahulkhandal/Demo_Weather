//
//  CurrentLocationWeatherInfoTableViewAdapter.swift
//  DemoWeather
//
//  Created by admin on 07/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

final class CurrentLocationWeatherInfoTableViewAdapter: NSObject {
  
  
  // MARK: - Constants Declaration
  
  fileprivate struct Defaults {
    static let estimatedRowHeight: CGFloat = 56.0
    static let sectionHeaderHeight: CGFloat = 52.0
  }
  
  // MARK: - Fileprivate Variables
  
  fileprivate let tableView: UITableView!
  fileprivate var weatherInfoList: [WeatherInfo] = []
    fileprivate var daysForecast: [String] = []
    fileprivate var dayMappedForecast:[String: [WeatherInfo]] = [:]
  // MARK: - Initialization Methods Implementation
  
  init(tableView: UITableView,
       weatherInfoList: [WeatherInfo]) {
    self.tableView = tableView
    self.weatherInfoList = weatherInfoList
    
    super.init()
    
    registerTableViewCells()
    configureTableView()
    tableView.reloadData()
  }
  
  // MARK: - Private Methods Implementation
  
  private func registerTableViewCells() {
    tableView.register(CityWeatherInfoTableViewCell.self)
  }
  
  private func configureTableView() {
    tableView.estimatedRowHeight = Defaults.estimatedRowHeight
    tableView.rowHeight = 100
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  // MARK: - Public Methods

  func update(_ weatherInfo: [WeatherInfo]) {
    self.weatherInfoList = weatherInfo
    mappedWeatherInfoByDate()
  }
  
    fileprivate func mappedWeatherInfoByDate() {
        
        var dict:[String: [WeatherInfo]] = [:]
        for info in self.weatherInfoList {
            let components = info.dateInfo.get(.day, .month, .year)
            var dateString = ""
            if let day = components.day?.description, let month = components.month?.description {
                dateString = "Day:" + day + " Month:" + month
            }
            
            if let infoarray = dict[dateString] {
                var value = infoarray
                value.append(info)
                dict[dateString] = value
            }
            else {
                dict[dateString] = [info]
            }
        }
        
        dayMappedForecast = dict
        daysForecast = Array(dict.keys)
    }
  func refreshLayout() {
    tableView.reloadData()
  }
}

// MARK: - UITableViewDataSource Implementation

extension CurrentLocationWeatherInfoTableViewAdapter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dayMappedForecast.count
    }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let key = daysForecast[section]
    let values = dayMappedForecast[key]
    return values?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let key = daysForecast[indexPath.section]
    let values = dayMappedForecast[key]
    guard let datasource = values else {
        fatalError("datasource issue")
    }
    
    let cell: CityWeatherInfoTableViewCell = tableView.dequeReusableCell()
    cell.configure(dataSource: datasource[indexPath.row])
    return cell
  }
}

// MARK: - UITableViewDelegate Methods Implementation

extension CurrentLocationWeatherInfoTableViewAdapter: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return Defaults.sectionHeaderHeight
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    let key = daysForecast[section]
    return key
  }
}

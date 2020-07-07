//
//  CitiesWeatherInfoTableViewAdapter.swift
//  DemoWeather
//
//  Created by admin on 06/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Foundation

final class CitiesWeatherInfoTableViewAdapter: NSObject {
  
  
  // MARK: - Constants Declaration
  
  fileprivate struct Defaults {
    static let estimatedRowHeight: CGFloat = 56.0
    static let sectionHeaderHeight: CGFloat = 12.0
  }
  
  // MARK: - Fileprivate Variables
  
  fileprivate let tableView: UITableView!
  fileprivate var weatherInfoList: [WeatherInfo] = []

  
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
  }
  
  func refreshLayout() {
    tableView.reloadData()
  }
}

// MARK: - UITableViewDataSource Implementation

extension CitiesWeatherInfoTableViewAdapter: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return weatherInfoList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell: CityWeatherInfoTableViewCell = tableView.dequeReusableCell()
    cell.configure(dataSource: weatherInfoList[indexPath.row])
    return cell
  }
}

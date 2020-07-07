//
//  CityWeatherInfoTableViewCell.swift
//  DemoWeather
//
//  Created by admin on 03/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class CityWeatherInfoTableViewCell: UITableViewCell, NibLoadableView {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var temperature: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
   @IBOutlet weak var windSpeedLabel: UILabel!
  
  // MARK: - Life Cycle Methods Implementation
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    temperature.text = nil
    descriptionLabel.text = nil
    windSpeedLabel.text = nil
  }
  
  // MARK: - Configuration Method
  
    func configure(dataSource: WeatherInfo) {
        if let min = dataSource.temp.min, let max = dataSource.temp.max {
        temperature.text = "Temp Min: \(String(describing: min)) Max: \(String(describing: max))"
        }
        descriptionLabel.text = "Weather:" + (dataSource.weatherDescription.first?.description ?? "")
        if let speed = dataSource.windInfo.speed {
            windSpeedLabel.text = "WindSpeed:" + String(describing:speed)
        }
        
  }
}

//
//  CitiesWeatherInfoViewController.swift
//  DemoWeather
//
//  Created by admin on 06/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

final class CitiesWeatherInfoViewController: UIViewController {

// MARK: - IBOutlets declaration

@IBOutlet weak var tableView: UITableView!
@IBOutlet weak var citiesTextView: UITextView!
    

// MARK: - fileprivate Variables

fileprivate var tableViewAdapter: CitiesWeatherInfoTableViewAdapter?

// MARK: - Internal variables

var presenter: CitiesWeatherInfoPresenter!

// MARK: - Class Methods Implementation

override class func containerStoryboardName() -> String {
  return Constants.Storyboard.main
}

public static func build() -> CitiesWeatherInfoViewController {
  
  guard let citiesWeatherInfoVC = CitiesWeatherInfoViewController.initFromNib() as? CitiesWeatherInfoViewController else {
    fatalError("View Controller doesnot exist")
  }
  
let presenter = CitiesWeatherInfoPresenterImpl(view: citiesWeatherInfoVC, cities: [])
 
  
  citiesWeatherInfoVC.presenter = presenter
    let interactor = CitiesWeatherInfoInteractorImpl.init(output: presenter, apiService: WeatherApiService.shared)
    
    presenter.interactor = interactor
  return citiesWeatherInfoVC
}

// MARK: - View Lifecycle Method

override func viewDidLoad() {
  super.viewDidLoad()
  presenter.onViewDidLoad()
}
    
    @IBAction func btnGetWeatherInfoTapped() {
        let citiesString = citiesTextView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if !citiesString.isEmpty {
        let cityArray = citiesTextView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).components(separatedBy: ",")
        presenter.onShowWeatherClick(cities: cityArray)
        }
    }

}

extension CitiesWeatherInfoViewController: CitiesWeatherInfoView {
    func prepareTableViewAdapter(datasource: [WeatherInfo]) {
    
        tableViewAdapter = CitiesWeatherInfoTableViewAdapter(tableView: tableView, weatherInfoList: datasource)
    
    }
    
     
   func showAlert(message: String) {
     DispatchQueue.main.async {
       let alertController = UIAlertController(title: nil,
                                               message: message,
                                               preferredStyle: .alert)
       alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
       self.present(alertController, animated: false, completion: nil)
     }
   }
    
    func showHud(message: String?) {
        
    }
    
    func removeHud() {
        
    }
    
    func updateAdapter(datasource: [WeatherInfo]) {
        tableViewAdapter?.update(datasource)
    }
    
    func refreshLayout() {
        tableViewAdapter?.refreshLayout()
    }
    
}

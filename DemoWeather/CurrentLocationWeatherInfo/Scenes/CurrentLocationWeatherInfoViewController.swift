//
//  CurrentLocationWeatherInfoViewController.swift
//  DemoWeather
//
//  Created by admin on 07/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

final class CurrentLocationWeatherInfoViewController: UIViewController {

// MARK: - IBOutlets declaration

@IBOutlet weak var tableView: UITableView!
    

// MARK: - fileprivate Variables

fileprivate var tableViewAdapter: CurrentLocationWeatherInfoTableViewAdapter?

// MARK: - Internal variables

var presenter: CurrentLocationWeatherInfoPresenter!

// MARK: - Class Methods Implementation

override class func containerStoryboardName() -> String {
  return Constants.Storyboard.main
}

    public static func build(latitude: Double, longitude: Double) -> CurrentLocationWeatherInfoViewController {
        
        guard let infoVC = CurrentLocationWeatherInfoViewController.initFromNib() as? CurrentLocationWeatherInfoViewController else {
            fatalError("View Controller doesnot exist")
        }
        
        let presenter = CurrentLocationWeatherInfoPresenterImpl(view: infoVC, latitude: latitude, longitude: longitude)
        
        
        infoVC.presenter = presenter
        let interactor = CurrentLocationWeatherInfoInteractorImpl.init(output: presenter, apiService: WeatherApiService.shared)
        
        presenter.interactor = interactor
        return infoVC
    }

// MARK: - View Lifecycle Method

override func viewDidLoad() {
  super.viewDidLoad()
  presenter.onViewDidLoad()
}
    
}

extension CurrentLocationWeatherInfoViewController: CurrentLocationWeatherInfoView {
    func prepareTableViewAdapter(datasource: [WeatherInfo]) {
    
        tableViewAdapter = CurrentLocationWeatherInfoTableViewAdapter(tableView: tableView, weatherInfoList: datasource)
    
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

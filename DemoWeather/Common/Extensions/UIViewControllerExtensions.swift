//
//  UIViewControllerExtensions.swift
//  DemoWeather
//
//  Created by admin on 03/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

extension UIViewController {
 @objc class func containerStoryboardName() -> String {
    // Default is main
    return Constants.Storyboard.main
  }
  
 @objc class func initFromNib() -> UIViewController {
    return UIStoryboard.init(name: containerStoryboardName(), bundle: nil).instantiateViewController(withIdentifier: String(describing: self))
  }
}

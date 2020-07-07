//
//  UIView+Reusable.swift
//  DemoWeather
//
//  Created by admin on 03/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

protocol ReusableView: class {
  static func defaultReuseIdentifier() -> String
}

extension ReusableView where Self: UIView {
  static func defaultReuseIdentifier() -> String {
    return String(describing: self)
  }
}

extension UITableViewCell: ReusableView {
  
}

extension UICollectionViewCell: ReusableView {
  
}

extension UITableViewHeaderFooterView: ReusableView {

}

protocol NibLoadableView: class {
  static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
  static var nibName: String {
    return String(describing: self)
  }
}

extension UITableView {
  
  func register<T: UITableViewCell>(_: T.Type) {
    register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier())
  }
  
  func register<T: UITableViewCell>(_: T.Type) where T: NibLoadableView {
    let bundle = Bundle(for: T.self)
    let nib = UINib(nibName: T.nibName, bundle: bundle)
    
    register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier())
  }
  
  func dequeReusableCell<T: UITableViewCell>() -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier()) as? T else {
      fatalError("Could not dequeue cell with identifier \(T.defaultReuseIdentifier())")
    }
    
    return cell
  }
  
  func dequeReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier(), for: indexPath) as? T else {
      fatalError("Could not dequeue cell with identifier \(T.defaultReuseIdentifier())")
    }
    
    return cell
  }
  
}

//
extension UITableView {

  func register<T: UITableViewHeaderFooterView>(_: T.Type) {
    register(T.self, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier())
  }

  func register<T: UITableViewHeaderFooterView>(_: T.Type) where T: NibLoadableView {
    let bundle = Bundle(for: T.self)
    let nib = UINib(nibName: T.nibName, bundle: bundle)

    register(nib, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier())
  }

  func dequeReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
    guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier()) as? T else {
      fatalError("Could not dequeue headerFooterView with identifier \(T.defaultReuseIdentifier())")
    }

    return cell
  }

}

extension UICollectionView {

  func register<T: UICollectionViewCell>(_: T.Type) {
    register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier())
  }
  
  func register<T: UICollectionViewCell>(_: T.Type) where T: NibLoadableView {
    let bundle = Bundle(for: T.self)
    let nib = UINib(nibName: T.nibName, bundle: bundle)

    register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier())
  }
  
  func dequeReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier(), for: indexPath) as? T else {
      fatalError("Could not dequeue cell with identifier \(T.defaultReuseIdentifier())")
    }
    
    return cell
  }
}

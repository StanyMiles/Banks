//
//  UIViewController+Ext.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 19.10.2020.
//

import UIKit

// MARK: - Alerts
extension UIViewController {
  
  func presentAlert(
    title: String? = nil,
    message: String? = nil,
    preferredStyle: UIAlertController.Style = .alert,
    actions: [UIAlertAction]? = nil,
    completion: (() -> Void)? = nil
  ) {
    
    let alert = UIAlertController(
      title: title,
      message: message,
      preferredStyle: preferredStyle)
    
    if let actions = actions {
      actions.forEach { alert.addAction($0) }
    } else {
      alert.addAction(.ok)
    }
    
    present(
      alert,
      animated: true,
      completion: completion)
  }
  
}

// MARK: - Error handler
extension UIViewController {
  
  func handle(
    _ error: Error,
    retryHandler: (() -> Void)? = nil
  ) {
    handle(error, from: self, retryHandler: retryHandler)
  }
}

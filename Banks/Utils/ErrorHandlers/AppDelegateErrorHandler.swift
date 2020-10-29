//
//  AppDelegateErrorHandler.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 19.10.2020.
//

import UIKit

extension AppDelegate {
  
  override func handle(
    _ error: Error,
    from viewController: UIViewController,
    retryHandler: (() -> Void)? = nil
  ) {
    
    let alert = UIAlertController(
      title: "An error occured",
      message: error.localizedDescription,
      preferredStyle: .alert)
    
    alert.addAction(.dismiss)
    
    switch error.resolveCategory() {
      
      case .retryable:
        alert.addAction(UIAlertAction(
          title: "Retry",
          style: .default,
          handler: { _ in retryHandler?() }
        ))
        
      case .nonRetryable:
        break
    }
    
    viewController.present(alert, animated: true)
  }
}

//
//  UIResponder+Ext.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 19.10.2020.
//

import UIKit

extension UIResponder {
  
  // Dispatching method through the Objective-C runtime,
  // to enable override it within subclasses
  @objc
  func handle(
    _ error: Error,
    from viewController: UIViewController,
    retryHandler: (() -> Void)? = nil
  ) {
    // This assertion will help us identify errors that were
    // either emitted by a view controller *before* it was
    // added to the responder chain, or never handled at all:
    guard let nextResponder = next else {
      return assertionFailure("Unhandled error \(error) from \(viewController)")
    }
    
    nextResponder.handle(
      error,
      from: viewController,
      retryHandler: retryHandler
    )
  }
}


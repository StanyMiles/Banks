//
//  Error+Ext.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 19.10.2020.
//

import Foundation

extension Error {
  
  func resolveCategory() -> ErrorCategory {
    
    guard let categorized = self as? CategorizedError else {
      return .nonRetryable
    }
    
    return categorized.category
  }
}

//
//  LoadingError.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 27.10.2020.
//

import Foundation

enum LoadingError {
  case noData, system(Error)
  
  var errorDescription: String? {
    
    switch self {
      
      case .noData:
        return "No data"
        
      case .system(let error):
        return "System error: \(error.localizedDescription)"
    }
  }
}

// MARK: - LocalizedError
extension LoadingError: LocalizedError {}

// MARK: - CategorizedError
extension LoadingError: CategorizedError {
  
  var category: ErrorCategory {
    
    switch self {
      
      case .noData:
        return .retryable
        
      case .system:
        return .nonRetryable
    }
  }
}

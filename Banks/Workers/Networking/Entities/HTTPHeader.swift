//
//  HTTPHeader.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 29.10.2020.
//

import Foundation

enum HTTPHeader {
  case contentType(HTTPContentType)  
}

extension HTTPHeader {
  
  typealias Parameters = (field: String, value: String)
  
  var parameters: Parameters {
    
    switch self {
      
      case .contentType(let type):
        return ("Content-Type", type.rawValue)
    }
  }
}

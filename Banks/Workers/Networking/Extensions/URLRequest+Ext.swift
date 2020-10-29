//
//  URLRequest+Ext.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 29.10.2020.
//

import Foundation

extension URLRequest {
  
  mutating func addHeader(_ header: HTTPHeader) {
    
    let (field, value) = header.parameters
    addValue(value, forHTTPHeaderField: field)
  }
}

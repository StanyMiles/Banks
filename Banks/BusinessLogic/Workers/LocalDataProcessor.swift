//
//  LocalDataProcessor.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 27.10.2020.
//

import Foundation

struct LocalDataProcessor: DataProcessor {
  
  // MARK: - Properties
  
  private let decoder: JSONDecoder
  
  // MARK: - Lifecycle
  
  init(decoder: JSONDecoder = .init()) {
    self.decoder = decoder
  }
  
  // MARK: - Funcs
  
  func process(
    _ data: Data
  ) throws -> [BankLocation] {
    
    try decoder.decode([BankLocation].self, from: data)
  }
}

//
//  DataProcessor.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 27.10.2020.
//

import Foundation

protocol DataProcessor {
  func process(_ data: Data) throws -> [BankLocation]
}

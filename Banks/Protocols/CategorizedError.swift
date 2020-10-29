//
//  CategorizedError.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 19.10.2020.
//

import Foundation

protocol CategorizedError: Error {
  var category: ErrorCategory { get }
}

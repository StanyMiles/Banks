//
//  Country.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 18.10.2020.
//

import Foundation

enum Country: String {
  case et = "Estonia"
  case lv = "Latvia"
  case lt = "Lithuania"
}

// MARK: - CaseIterable
extension Country: CaseIterable {}

// MARK: - Codable
extension Country: Codable {}

// MARK: - Comparable
extension Country: Comparable {
  
  static func < (lhs: Country, rhs: Country) -> Bool {
    lhs.rawValue.compare(rhs.rawValue) == .orderedAscending
  }
}

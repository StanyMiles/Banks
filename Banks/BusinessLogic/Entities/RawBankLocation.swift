//
//  RawBankLocation.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 21.10.2020.
//

import Foundation

struct RawBankLocation {
  
  let lat: Double
  let lon: Double
  let name: String
  let address: String
  let type: BankLocationType
  let region: String?
  let availability: String?
  let info: String?
  let hasNoCash: Bool?
  let hasCoinStation: Bool?
  
  enum CodingKeys: String, CodingKey {
    case lat
    case lon
    case name = "n"
    case address = "a"
    case type = "t"
    case region = "r"
    case availability = "av"
    case info = "i"
    case hasNoCash = "ncash"
    case hasCoinStation = "cs"
  }
}

// MARK: - Codable
extension RawBankLocation: Codable {}

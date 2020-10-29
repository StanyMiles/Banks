//
//  BankLocation.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 18.10.2020.
//

import Foundation

struct BankLocation {
  
  // MARK: - Properties
  
  let id: UUID
  let lat: Double
  let lon: Double
  let name: String
  let address: String
  let type: BankLocationType
  let region: String
  let availability: String?
  let info: String?
  let hasNoCash: Bool?
  let hasCoinStation: Bool?
  
  // MARK: - Lifecycle
  
  init?(rawBankLocation: RawBankLocation) {
    
    guard let region = rawBankLocation.region else { return nil }
    
    id = UUID()
    lat = rawBankLocation.lat
    lon = rawBankLocation.lon
    name = rawBankLocation.name
    address = rawBankLocation.address
    type = rawBankLocation.type
    self.region = region
    availability = rawBankLocation.availability
    info = rawBankLocation.info
    hasNoCash = rawBankLocation.hasNoCash
    hasCoinStation = rawBankLocation.hasCoinStation
  }
  
}

// MARK: - Codable
extension BankLocation: Codable {}

// MARK: - Comparable
extension BankLocation: Comparable {
  
  static func < (lhs: BankLocation, rhs: BankLocation) -> Bool {
    lhs.name.compare(rhs.name) == .orderedAscending
  }
}

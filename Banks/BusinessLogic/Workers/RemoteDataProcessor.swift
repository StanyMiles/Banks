//
//  RemoteDataProcessor.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 27.10.2020.
//

import Foundation

struct RemoteDataProcessor: DataProcessor {
  
  // MARK: - Properties
  
  private let country: Country
  private let localStorage: BanksDataStorable
  private let decoder: JSONDecoder
  
  // MARK: - Lifecycle
  
  init(
    country: Country,
    localStorage: BanksDataStorable,
    decoder: JSONDecoder = .init()
  ) {
    self.country = country
    self.localStorage = localStorage
    self.decoder = decoder
  }
  
  // MARK: - Funcs
  
  func process(
    _ data: Data
  ) throws -> [BankLocation] {
    
    let rawLocations = try decoder
      .decode([RawBankLocation].self, from: data)
    
    let bankLocations = rawLocations
      .compactMap({ BankLocation(rawBankLocation: $0) })
    
    storeLocally(bankLocations, for: country)
    
    return bankLocations
  }
  
  private func storeLocally(
    _ bankLocations: [BankLocation],
    for country: Country,
    encoder: JSONEncoder = .init()
  ) {
    
    do {
      let data = try encoder.encode(bankLocations)
      localStorage.save(data, for: country)
      
    } catch {
      fatalError("Failed to encode locations for '\(country.rawValue)': \(error.localizedDescription)")
    }
  }
}

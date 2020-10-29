//
//  LocalStorage.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 18.10.2020.
//

import Foundation

/// Loads and saves data locally
struct LocalStorage {
  
  // MARK: - Properties
  
  private let dataStorage: LocalDataStorable
  
  // MARK: - Lifecycle
  
  init(dataStorage: LocalDataStorable = UserDefaults.standard) {
    self.dataStorage = dataStorage
  }
}

// MARK: - BanksDataStorable
extension LocalStorage: BanksDataStorable {
  
  func fetchBanksData(
    for country: Country,
    completion: @escaping (Result<Data, LoadingError>) -> Void
  ) {
    
    guard let data = dataStorage.data(forKey: country.rawValue) else {
      completion(.failure(.noData))
      return
    }
    
    completion(.success(data))
  }
  
  func cancel(for country: Country) {
    fatalError("Cancellation of loading in LocalStorage is not supported")
  }
  
  func save(
    _ bankData: Data,
    for country: Country
  ) {
    
    dataStorage.setValue(bankData, forKey: country.rawValue)
  }
}

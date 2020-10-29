//
//  DataManager.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 18.10.2020.
//

import Foundation

final class DataManager {
  
  // MARK: - Properties
  
  private let remoteStorage: BanksDataLoadable
  private let localStorage: BanksDataStorable
  private let queue: OperationQueue

  private var allBankLocations: [Country: [BankLocation]] = [:]
  private var lastDownloaded: Date?
  private var downloadError: Error?

  // MARK: - Lifecycle
  
  init(
    remoteStorage: BanksDataLoadable = RemoteStorage(),
    localStorage: BanksDataStorable = LocalStorage(),
    queue: OperationQueue = OperationQueue()
  ) {
    self.remoteStorage = remoteStorage
    self.localStorage = localStorage
    self.queue = queue
  }
  
  // MARK: - Funcs
  
  private func fetchBankLocations(
    from storage: BanksDataLoadable,
    dataProcessor: DataProcessor,
    completion: @escaping (Result<[CountrySection], LoadingError>) -> Void
  ) {

    let operationsCompletion = makeCompletionOperation(completion: completion)

    for country in Country.allCases {

      let operation = makeLoadingOperation(
        for: country,
        storage: storage,
        dataProcessor: dataProcessor
      ) { [weak self] result in

        guard let self = self else { return }
        self.handle(result, for: country)
      }

      queue.addOperation(operation)
      operationsCompletion.addDependency(operation)
    }

    queue.addOperation(operationsCompletion)
  }
  
  private func fetchBankLocations(
    from remoteStorage: BanksDataLoadable,
    saveTo localStorage: BanksDataStorable,
    completion: @escaping (Result<[CountrySection], LoadingError>) -> Void
  ) {
    
    let operationsCompletion = makeCompletionOperation(completion: completion)
    
    for country in Country.allCases {
      
      let dataProcessor = RemoteDataProcessor(
        country: country,
        localStorage: localStorage)
      
      let operation = makeLoadingOperation(
        for: country,
        storage: remoteStorage,
        dataProcessor: dataProcessor
      ) { [weak self] result in
        
        guard let self = self else { return }
        self.handle(result, for: country)
      }
      
      queue.addOperation(operation)
      operationsCompletion.addDependency(operation)
    }
    
    queue.addOperation(operationsCompletion)
  }
  
  private func makeLoadingOperation(
    for country: Country,
    storage: BanksDataLoadable,
    dataProcessor: DataProcessor,
    completion: @escaping (Result<[BankLocation], LoadingError>) -> Void
  ) -> AsyncOperation {
    
    BanksDataLoadingOperation(
      country: country,
      storage: storage
    ) { result in
      
      switch result {
        
        case .success(let data):
          do {
            let bankLocations = try dataProcessor.process(data)
            completion(.success(bankLocations))
            
          } catch {
            completion(.failure(.system(error)))
          }
          
        case .failure(let error):
          completion(.failure(.system(error)))
      }
    }
  }
  
  private func makeCompletionOperation(
    completion: @escaping (Result<[CountrySection], LoadingError>) -> Void
  ) -> BlockOperation {
    
    BlockOperation { [weak self] in
      guard let self = self else { return }
      
      if let downloadError = self.downloadError {
        completion(.failure(.system(downloadError)))
        return
      }
      
      let countries = self.allBankLocations.keys.sorted()
      
      let countrySections = countries
        .map({ country -> CountrySection in
          
          let bankLocations = self.allBankLocations[country] ?? []
          let regions = bankLocations.map({ $0.region })
          
          let regionsSet = Set(regions)
          let regionsArray = Array(regionsSet)
          let sortedRegions = regionsArray.sorted()
          
          return CountrySection(country: country, regions: sortedRegions)
        })
      
      completion(.success(countrySections))
      
      self.lastDownloaded = Date()
    }
  }
  
  private func handle(
    _ result: Result<[BankLocation], LoadingError>,
    for country: Country
  ) {
    
    switch result {
      
      case .success(let bankLocations):
        self.allBankLocations[country] = bankLocations
        
      case .failure(let error):
        self.downloadError = error
    }
  }
  
}

// MARK: - BankLocationsLoadable
extension DataManager: BankLocationsLoadable {
  
  func fetchAllBankLocations(
    completion: @escaping (Result<[CountrySection], LoadingError>) -> Void
  ) {
    
    allBankLocations.removeAll()
    downloadError = nil
    
    if let lastDownloaded = lastDownloaded, lastDownloaded.isLessThanHourAgo() {

      fetchBankLocations(
        from: localStorage,
        dataProcessor: LocalDataProcessor()
      ) { [weak self] result in
        
        guard let self = self else { return }
        
        switch result {
          
          case .success(let sections):
            completion(.success(sections))
            
          case .failure:
            // If falied to load from local -> load from remote
            
            self.fetchBankLocations(
              from: self.remoteStorage,
              saveTo: self.localStorage,
              completion: completion)
        }
      }

    } else {
      // Loaded more than a hour ago or never

      fetchBankLocations(
        from: remoteStorage,
        saveTo: localStorage,
        completion: completion)
    }
  }
  
  func fetchBankLocations(
    withRegion region: String,
    completion: @escaping (Result<[BankLocation], LoadingError>) -> Void
  ) {
    
    let locations = allBankLocations
      .flatMap({ $0.value })
      .filter({ $0.region == region })
      .sorted()
    
    completion(.success(locations))
  }
  
  func fetchBankLocation(
    withID id: UUID,
    completion: @escaping (Result<BankLocation, LoadingError>) -> Void
  ) {
    
    guard let location = allBankLocations
            .flatMap({ $0.value })
            .first(where: { $0.id == id })
    else {
      completion(.failure(.noData))
      return
    }
    
    completion(.success(location))
  }
  
}

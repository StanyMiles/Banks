//
//  BanksDataLoadingOperation.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 27.10.2020.
//

import Foundation

final class BanksDataLoadingOperation: AsyncOperation {
  
  typealias Output = (Result<Data, Error>) -> Void
  
  // MARK: - Properties
  
  private let country: Country
  private let storage: BanksDataLoadable
  private let completionHandler: Output
  
  // MARK: - Lifecycle
  
  init(
    country: Country,
    storage: BanksDataLoadable,
    completionHandler: @escaping Output
  ) {
    
    self.country = country
    self.storage = storage
    self.completionHandler = completionHandler
    
    super.init()
  }
  
  // MARK: - Funcs
  
  override func main() {
    
    storage.fetchBanksData(
      for: country
    ) { [weak self] result in
      
      guard let self = self else { return }
      
      defer { self.state = .finished }
      
      switch result {
        
        case .success(let data):
          self.completionHandler(.success(data))
          
        case .failure(let error):
          self.completionHandler(.failure(error))
      }
    }
  }
}

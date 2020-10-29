//
//  RegionsInteractor.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 18.10.2020.
//

import Foundation

struct RegionsInteractor {
  
  // MARK: - Properties
  
  private let worker: BankLocationsLoadable
  private let presenter: RegionsPresentable
  
  // MARK: - Lifecycle
  
  init(
    worker: BankLocationsLoadable,
    presenter: RegionsPresentable
  ) {
    self.worker = worker
    self.presenter = presenter
  }
}

// MARK: - RegionsInteractable
extension RegionsInteractor: RegionsInteractable {
  
  func fetchBanks() {
    
    worker.fetchAllBankLocations { result in
      
      switch result {

        case .success(let sections):
          presenter.didFetch(sections)

        case .failure(let error):
          presenter.didFail(with: error)
      }
    }
  }
  
}

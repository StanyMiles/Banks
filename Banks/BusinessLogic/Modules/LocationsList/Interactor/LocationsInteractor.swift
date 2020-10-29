//
//  LocationsInteractor.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 22.10.2020.
//

import Foundation

struct LocationsInteractor {
  
  // MARK: - Properties
  
  private let region: String
  private let worker: BankLocationsLoadable
  private let presenter: LocationsPresentable
  
  // MARK: - Lifecycle
  
  init(
    region: String,
    worker: BankLocationsLoadable,
    presenter: LocationsPresentable
  ) {
    self.region = region
    self.worker = worker
    self.presenter = presenter
  }
}

// MARK: - LocationsInteractable
extension LocationsInteractor: LocationsInteractable {
  
  func fetchLocations() {
    
    worker.fetchBankLocations(
      withRegion: region
    ) { result in
      
      switch result {
        
        case .success(let locations):
          presenter.didFetch(locations)
          
        case .failure(let error):
          presenter.didFail(with: error)
      }
    }
  }
}

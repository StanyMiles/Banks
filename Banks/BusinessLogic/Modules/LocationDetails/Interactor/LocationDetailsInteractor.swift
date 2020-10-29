//
//  LocationDetailsInteractor.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 28.10.2020.
//

import Foundation

struct LocationDetailsInteractor {
  
  // MARK: - Properties
  
  private let locationID: UUID
  private let presenter: LocationDetailsPresentable
  private let dataManager: BankLocationsLoadable
  
  // MARK: - Lifecycle
  
  init(
    locationID: UUID,
    presenter: LocationDetailsPresentable,
    dataManager: BankLocationsLoadable
  ) {
    self.locationID = locationID
    self.presenter = presenter
    self.dataManager = dataManager
  }
}

// MARK: - LocationDetailsInteractable
extension LocationDetailsInteractor: LocationDetailsInteractable {
  
  func fetchLocationDetails() {
    
    dataManager.fetchBankLocation(withID: locationID) { result in
      
      switch result {
        
        case .success(let location):
          presenter.presentDetails(for: location)
          
        case .failure(let error):
          presenter.didFail(with: error)
      }
    }
  }
}

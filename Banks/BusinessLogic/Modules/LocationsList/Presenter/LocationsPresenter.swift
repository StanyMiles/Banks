//
//  LocationsPresenter.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 22.10.2020.
//

import Foundation

struct LocationsPresenter {
  
  // MARK: - Properties
  
  private weak var view: LocationsListable?
  
  // MARK: - Lifecycle
  
  init(view: LocationsListable) {
    self.view = view
  }
}

// MARK: - LocationsPresentable
extension LocationsPresenter: LocationsPresentable {
  
  func didFetch(_ locations: [BankLocation]) {
    
    guard let view = view else { return }
    
    let regionName = locations.first?.region ?? ""
    let viewModel = LocationsListViewModel(navigationBarTitle: regionName, locations: locations)
    
    DispatchQueue.main.async {
      view.set(viewModel)
    }
  }
  
  func didFail(with error: Error) {
    
    guard let view = view else { return }
    
    DispatchQueue.main.async {
      view.showError(error)
    }
  }
  
}

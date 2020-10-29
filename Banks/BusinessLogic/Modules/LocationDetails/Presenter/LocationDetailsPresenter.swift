//
//  LocationDetailsPresenter.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 28.10.2020.
//

import Foundation

struct LocationDetailsPresenter {
  
  // MARK: - Properties
  
  private weak var view: LocationDetailsShowable?
  
  // MARK: - Lifecycle
  
  init(view: LocationDetailsShowable) {
    self.view = view
  }
}

// MARK: - LocationDetailsPresentable
extension LocationDetailsPresenter: LocationDetailsPresentable {
  
  func presentDetails(for location: BankLocation) {
    
    guard let view = view else { return }
    
    let firstSection: [LocationDetailsViewModel.Details] = [
      (name: "type", value: location.type.description),
      (name: "name", value: location.name),
      (name: "address", value: location.address),
      (name: "region", value: location.region),
    ]
    
    var secondSection: [LocationDetailsViewModel.Details] = []
    
    if let availability = location.availability {
      secondSection.append((name: "availability", value: availability))
    }
    if let info = location.info {
      secondSection.append((name: "info", value: info))
    }
    
    var sections = [firstSection]
    
    if !secondSection.isEmpty {
      sections.append(secondSection)
    }
    
    let viewModel = LocationDetailsViewModel(
      navigationBarTitle: location.name,
      sections: sections)
    
    DispatchQueue.main.async {
      view.showLocationDetails(viewModel: viewModel)
    }
  }
  
  func didFail(with error: Error) {
    
    guard let view = view else { return }
    
    DispatchQueue.main.async {
      view.showError(error)
    }
  }
  
}

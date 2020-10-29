//
//  RegionsPresenter.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 18.10.2020.
//

import Foundation

struct RegionsPresenter {
  
  // MARK: - Properties
  
  private weak var view: RegionsListable?
  
  // MARK: - Lifecycle
  
  init(view: RegionsListable) {
    self.view = view
  }
}

// MARK: - RegionsPresentable
extension RegionsPresenter: RegionsPresentable {
  
  func didFetch(_ countries: [CountrySection]) {

    guard let view = view else { return }
    
    let viewModel = RegionsListViewModel(sections: countries)
    
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

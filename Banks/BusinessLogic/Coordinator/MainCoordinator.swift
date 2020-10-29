//
//  MainCoordinator.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 18.10.2020.
//

import UIKit

class MainCoordinator: Coordinator {
  
  // MARK: - Properties
  
  var navigationController: UINavigationController
  var childCoordinators: [Coordinator] = []
  
  private let dataManager: BankLocationsLoadable
  
  // MARK: - Lifecycle
  
  init(
    navigationController: UINavigationController,
    dataManager: BankLocationsLoadable
  ) {
    self.navigationController = navigationController
    self.dataManager = dataManager
  }
  
  // MARK: - Funcs
  
  func start() {
    
    let regionsListController = RegionsListController()
    
    let presenter = RegionsPresenter(view: regionsListController)

    let interactor = RegionsInteractor(
      worker: dataManager,
      presenter: presenter)
    
    regionsListController.interactor = interactor
    regionsListController.coordinator = self
    
    navigationController.pushViewController(regionsListController, animated: false)
  }
}

// MARK: - BanksCoordinator
extension MainCoordinator: BanksCoordinator {
  
  func showLocations(withRegion region: String) {
    
    let locationsListController = LocationsListController()
    
    let presenter = LocationsPresenter(view: locationsListController)
    
    let interactor = LocationsInteractor(
      region: region,
      worker: dataManager,
      presenter: presenter)
    
    locationsListController.interactor = interactor
    locationsListController.coordinator = self
    locationsListController.cellUIManager = LocationTableCellUIManager()
    
    navigationController.pushViewController(locationsListController, animated: true)
  }
  
  func showLocationDetails(withID id: UUID) {
    
    let locationDetailsController = LocationDetailsController()
    
    let presenter = LocationDetailsPresenter(view: locationDetailsController)
    
    let interactor = LocationDetailsInteractor(
      locationID: id,
      presenter: presenter,
      dataManager: dataManager)
    
    locationDetailsController.interactor = interactor
    
    navigationController.pushViewController(locationDetailsController, animated: true)
  }
  
}

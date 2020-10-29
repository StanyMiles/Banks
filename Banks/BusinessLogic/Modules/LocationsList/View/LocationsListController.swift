//
//  LocationsListController.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 21.10.2020.
//

import UIKit

final class LocationsListController: UITableViewController {
  
  // MARK: - Properties
  
  var coordinator: BanksCoordinator?
  var interactor: LocationsInteractable?
  var cellUIManager: CellUIManager?
  
  private var viewModel: LocationsListData = LocationsListViewModel(navigationBarTitle: "", locations: [])
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    loadData()
  }
  
  // MARK: - Funcs
  
  private func loadData() {
    
    guard let interactor = interactor else {
      fatalError("LocationsInteractable MUST be instantiated in LocationsListController")
    }
    
    interactor.fetchLocations()
  }
  
  private func setupViews() {
    
    // TableView
    tableView = CustomTableView()
    tableView.register(LocationTableCell.self,
                       forCellReuseIdentifier: LocationTableCell.cellID)
  }
  
  private func setNavigationBarTitle(_ title: String) {
    navigationItem.title = title
  }
}

// MARK: - LocationsListable
extension LocationsListController: LocationsListable {

  func set(_ viewModel: LocationsListData) {

    setNavigationBarTitle(viewModel.navigationBarTitle)
    
    self.viewModel = viewModel
    tableView.reloadData()
  }

  func showError(_ error: Error) {

    handle(error)
  }

}

// MARK: - UITableViewDataSource
extension LocationsListController {
  
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    viewModel.locations.count
  }
  
  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LocationTableCell.cellID,
            for: indexPath) as? LocationTableCell
    else {
      fatalError("LocationTableCell is not registered in LocationsListController")
    }
    
    guard let cellUIManager = cellUIManager else {
      fatalError("CellUIManager MUST be injected to LocationsListController")
    }
    
    let location = viewModel.locations[indexPath.row]
    cell.setup(with: location, uiManager: cellUIManager)
    
    return cell
  }
}

// MARK: - UITableViewDelegate
extension LocationsListController {
  
  override func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    
    guard let coordinator = coordinator else {
      fatalError("MainCoordinator MUST be injected to LocationsListController")
    }
    
    let location = viewModel.locations[indexPath.row]
    coordinator.showLocationDetails(withID: location.id)
  }
  
}

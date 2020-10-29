//
//  RegionsListController.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 18.10.2020.
//

import UIKit

final class RegionsListController: UITableViewController {

  // MARK: - Properties
  
  var coordinator: BanksCoordinator?
  var interactor: RegionsInteractable?
  
  private var viewModel: RegionsListData = RegionsListViewModel(sections: [])
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    reloadData()
  }

  // MARK: - Funcs
  
  private func setupViews() {
    
    // NavigationBar
    navigationItem.title = "Regions"
    
    // TableView
    tableView = CustomTableView()
    
    // RefreshControl
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    self.refreshControl = refreshControl
  }
  
  @objc
  private func reloadData() {
    
    guard let interactor = interactor else {
      fatalError("RegionsInteractable MUST be injected to RegionsListController")
    }
    
    refreshControl?.beginRefreshing()
    
    interactor.fetchBanks()
  }

}

// MARK: - RegionsListable
extension RegionsListController: RegionsListable {
  
  func set(_ viewModel: RegionsListData) {
    
    refreshControl?.endRefreshing()
    
    self.viewModel = viewModel
    tableView.reloadData()
  }
  
  func showError(_ error: Error) {
    
    refreshControl?.endRefreshing()
    
    viewModel = RegionsListViewModel(sections: [])
    tableView.reloadData()
    
    handle(error)
  }
  
}

// MARK: - UITableViewDataSource
extension RegionsListController {

  override func numberOfSections(in tableView: UITableView) -> Int {
    viewModel.sections.count
  }
  
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    viewModel.sections[section].regions.count
  }
  
  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    
    let country = viewModel.sections[indexPath.section]
    let region = country.regions[indexPath.row]
    
    let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
    cell.textLabel?.text = region
    cell.accessoryType = .disclosureIndicator
    
    return cell
  }
}

// MARK: - UITableViewDelegate
extension RegionsListController {
  
  override func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    
    let section = viewModel.sections[indexPath.section]
    let region = section.regions[indexPath.row]
    
    guard let coordinator = coordinator else {
      fatalError("MainCoordinator MUST be injected to RegionsListController")
    }
    
    coordinator.showLocations(withRegion: region)
  }
  
  override func tableView(
    _ tableView: UITableView,
    viewForHeaderInSection section: Int
  ) -> UIView? {
    
    let section = viewModel.sections[section]
    
    let header = CountryHeaderView()
    header.titleLabel.text = section.country.rawValue
    
    return header
  }
  
  override func tableView(
    _ tableView: UITableView,
    heightForHeaderInSection section: Int
  ) -> CGFloat {
    
    32
  }
}

//
//  LocationDetailsController.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 27.10.2020.
//

import UIKit

final class LocationDetailsController: UITableViewController {
  
  // MARK: - Properties
  
  var interactor: LocationDetailsInteractable?
  
  private var viewModel: LocationDetailsData = LocationDetailsViewModel(navigationBarTitle: "", sections: [])
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    loadData()
  }
  
  // MARK: - Funcs
  
  private func loadData() {
    
    guard let interactor = interactor else {
      fatalError("LocationDetailsInteractable MUST be instantiated in LocationDetailsController")
    }
    
    interactor.fetchLocationDetails()
  }
  
  private func setupViews() {
    
    // TableView
    tableView = CustomTableView()
    tableView.register(LocationDetailsTableCell.self,
                       forCellReuseIdentifier: LocationDetailsTableCell.cellID)
  }
  
  private func setNavigationBarTitle(_ title: String) {
    navigationItem.title = title
  }
}

// MARK: - LocationDetailsShowable
extension LocationDetailsController: LocationDetailsShowable {

  func showLocationDetails(viewModel: LocationDetailsViewModel) {

    setNavigationBarTitle(viewModel.navigationBarTitle)

    self.viewModel = viewModel
    tableView.reloadData()
  }
  
  func showError(_ error: Error) {
    
    handle(error)
  }

}

// MARK: - UITableViewDataSource
extension LocationDetailsController {
  
  override func numberOfSections(
    in tableView: UITableView
  ) -> Int {
    viewModel.sections.count
  }
  
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    viewModel.sections[section].count
  }
  
  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LocationDetailsTableCell.cellID,
            for: indexPath) as? LocationDetailsTableCell
    else {
      fatalError("LocationDetailsTableCell is not registered in LocationDetailsController")
    }
    
    let section = viewModel.sections[indexPath.section]
    let details = section[indexPath.row]
    cell.setup(with: details)
    
    return cell
  }
}

// MARK: - UITableViewDelegate
extension LocationDetailsController {
  
  override func tableView(
    _ tableView: UITableView,
    heightForHeaderInSection section: Int
  ) -> CGFloat {
    
    40
  }
  
  override func tableView(
    _ tableView: UITableView,
    viewForHeaderInSection section: Int
  ) -> UIView? {
    
    let header = UIView()
    header.backgroundColor = .systemGray5
    return header
  }
}

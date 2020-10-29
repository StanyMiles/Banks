//
//  LocationsListable.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 22.10.2020.
//

import Foundation

protocol LocationsListable: class {
  func set(_ viewModel: LocationsListData)
  func showError(_ error: Error)
}

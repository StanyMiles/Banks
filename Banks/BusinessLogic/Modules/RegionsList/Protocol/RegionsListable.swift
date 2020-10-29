//
//  RegionsListable.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 18.10.2020.
//

import Foundation

protocol RegionsListable: class {
  func set(_ viewModel: RegionsListData)
  func showError(_ error: Error)
}

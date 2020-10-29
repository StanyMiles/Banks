//
//  LocationDetailsShowable.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 28.10.2020.
//

import Foundation

protocol LocationDetailsShowable: class {
  func showLocationDetails(viewModel: LocationDetailsViewModel)
  func showError(_ error: Error)
}

//
//  LocationDetailsPresentable.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 28.10.2020.
//

import Foundation

protocol LocationDetailsPresentable {
  func presentDetails(for location: BankLocation)
  func didFail(with error: Error)
}

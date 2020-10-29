//
//  LocationsPresentable.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 22.10.2020.
//

import Foundation

protocol LocationsPresentable {
  func didFetch(_ locations: [BankLocation])
  func didFail(with error: Error)
}

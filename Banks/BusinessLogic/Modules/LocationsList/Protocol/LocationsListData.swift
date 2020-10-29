//
//  LocationsListData.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 28.10.2020.
//

import Foundation

protocol LocationsListData {
  var navigationBarTitle: String { get }
  var locations: [BankLocation] { get }
}

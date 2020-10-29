//
//  LocationsListViewModel.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 26.10.2020.
//

import Foundation

struct LocationsListViewModel: LocationsListData {
  let navigationBarTitle: String
  let locations: [BankLocation]
}

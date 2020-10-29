//
//  BanksDataLoadable.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 20.10.2020.
//

import Foundation

protocol BanksDataLoadable {
  
  func fetchBanksData(
    for country: Country,
    completion: @escaping (Result<Data, LoadingError>) -> Void)
  
  func cancel(for country: Country)
}

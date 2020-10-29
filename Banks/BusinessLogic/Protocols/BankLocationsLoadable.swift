//
//  BankLocationsLoadable.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 18.10.2020.
//

import Foundation

protocol BankLocationsLoadable {
  
  func fetchAllBankLocations(
    completion: @escaping (Result<[CountrySection], LoadingError>) -> Void)
  
  func fetchBankLocations(
    withRegion region: String,
    completion: @escaping (Result<[BankLocation], LoadingError>) -> Void)
  
  func fetchBankLocation(
    withID id: UUID,
    completion: @escaping (Result<BankLocation, LoadingError>) -> Void)
}

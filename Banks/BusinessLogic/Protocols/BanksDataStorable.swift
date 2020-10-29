//
//  BanksDataStorable.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 20.10.2020.
//

import Foundation

protocol BanksDataStorable: BanksDataLoadable {
  
  func save(
    _ banksData: Data,
    for country: Country)
}

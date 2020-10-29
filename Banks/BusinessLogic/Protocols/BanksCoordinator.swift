//
//  BanksCoordinator.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 27.10.2020.
//

import Foundation

protocol BanksCoordinator: Coordinator {
  func showLocations(withRegion region: String)
  func showLocationDetails(withID id: UUID)
}

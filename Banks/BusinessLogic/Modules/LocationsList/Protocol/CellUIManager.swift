//
//  CellUIManager.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 28.10.2020.
//

import UIKit

protocol CellUIManager {
  func getColor(for locationType: BankLocationType) -> UIColor
}

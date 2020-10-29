//
//  LocationTableCellUIManager.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 28.10.2020.
//

import UIKit

struct LocationTableCellUIManager {
  
}

// MARK: - CellUIManager
extension LocationTableCellUIManager: CellUIManager {
  
  func getColor(for locationType: BankLocationType) -> UIColor {
    
    switch locationType {
      
      case .branch:
        return .blueish
        
      case .atm:
        return .orangeish
        
      case .bna:
        return .greenish
    }
  }
}

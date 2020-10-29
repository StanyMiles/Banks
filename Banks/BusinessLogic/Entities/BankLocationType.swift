//
//  BankLocationType.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 21.10.2020.
//

import Foundation

enum BankLocationType: Int, Codable {
  case branch, atm, bna
  
  var description: String {
    switch self {
      
      case .branch:
        return "Branch"
        
      case .atm:
        return "ATM (Automated Teller Machine)"
        
      case .bna:
        return "BNA (Bunch Note Acceptor)"
    }
  }
  
  var symbol: String {
    switch self {
      
      case .branch:
        return "BR"
        
      case .atm:
        return "A"
        
      case .bna:
        return "R"
    }
  }
}

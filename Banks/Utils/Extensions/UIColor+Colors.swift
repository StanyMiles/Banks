//
//  UIColor+Colors.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 28.10.2020.
//

import UIKit

extension UIColor {
  
  // MARK: - Properties
  
  static let greenish = named("greenish")
  static let orangeish = named("orangeish")
  static let blueish = named("blueish")
  
  // MARK: - Funcs
  
  private static func named(_ colorName: String) -> UIColor {
    
    guard let color = UIColor(named: colorName) else {
      fatalError("Color named '\(colorName)' is not provided in Assets.xcassets")
    }
    
    return color
  }
}

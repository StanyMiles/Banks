//
//  Date+Ext.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 18.10.2020.
//

import Foundation

extension Date {
  
  /// Calculates if timeinterval between the date and current moment is less than an hour
  func isLessThanHourAgo(calendar: Calendar = .current) -> Bool {
    
    let components = calendar
      .dateComponents(
        [.hour],
        from: self,
        to: Date())
    
    guard let hours = components.hour else { return false }
    
    return hours == 0
  }
}

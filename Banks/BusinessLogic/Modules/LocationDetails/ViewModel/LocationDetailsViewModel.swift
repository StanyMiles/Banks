//
//  LocationDetailsViewModel.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 27.10.2020.
//

import Foundation

struct LocationDetailsViewModel: LocationDetailsData {
  
  typealias Details = (name: String, value: String)
  
  // MARK: - Properties
  
  let navigationBarTitle: String
  let sections: [[Details]]
}

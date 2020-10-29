//
//  LocationDetailsData.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 28.10.2020.
//

import Foundation

protocol LocationDetailsData {
  
  typealias Details = (name: String, value: String)
  
  var navigationBarTitle: String { get }
  var sections: [[Details]] { get }
}

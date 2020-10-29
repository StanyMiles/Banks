//
//  RegionsPresentable.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 18.10.2020.
//

import Foundation

protocol RegionsPresentable {
  func didFetch(_ countries: [CountrySection])
  func didFail(with error: Error)
}

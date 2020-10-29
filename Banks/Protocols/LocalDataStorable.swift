//
//  LocalDataStorable.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 27.10.2020.
//

import Foundation

protocol LocalDataStorable {
  func setValue(_ value: Any?, forKey key: String)
  func data(forKey defaultName: String) -> Data?
}

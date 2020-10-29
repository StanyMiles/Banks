//
//  KeyValueHolder.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 29.10.2020.
//

import Foundation

protocol KeyValueHolder {
  
  associatedtype Key = Hashable
  associatedtype Value
  
  func getValue(
    forKey key: Key,
    completion: @escaping (Value?) -> Void
  )
  
  func set(
    _ value: Value,
    forKey key: Key
  )
  
  func remove(forKey key: Key)
}

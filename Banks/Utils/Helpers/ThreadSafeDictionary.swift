//
//  ThreadSafeDictionary.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 29.10.2020.
//

import Foundation

final class ThreadSafeDictionary<Key: Hashable, Value> {
  
  // MARK: - Properties
  
  private let concurrentQueue = DispatchQueue(
    label: "com.kobiletski.Banks.thread.safe.dictionary",
    attributes: .concurrent)
  
  private var dictionary: [Key: Value] = [:]
  
}

// MARK: - KeyValueHolder
extension ThreadSafeDictionary: KeyValueHolder {
  
  func getValue(
    forKey key: Key,
    completion: @escaping (Value?) -> Void
  ) {
    
    concurrentQueue.async(flags: .barrier) {
      let value = self.dictionary[key]
      completion(value)
    }
  }
  
  func set(
    _ value: Value,
    forKey key: Key
  ) {
    
    concurrentQueue.async(flags: .barrier) {
      self.dictionary[key] = value
    }
  }
  
  func remove(forKey key: Key) {
    
    concurrentQueue.async(flags: .barrier) {
      self.dictionary.removeValue(forKey: key)
    }
  }
}

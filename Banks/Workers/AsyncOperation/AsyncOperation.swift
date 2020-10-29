//
//  AsyncOperation.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 20.10.2020.
//

import Foundation

class AsyncOperation: Operation {

  enum State: String {
    case ready, executing, finished

    fileprivate var keyPath: String {
      return "is\(rawValue.capitalized)"
    }
  }

  // MARK: - Properties

  var state = State.ready {
    willSet {
      willChangeValue(forKey: newValue.keyPath)
      willChangeValue(forKey: state.keyPath)
    }
    didSet {
      didChangeValue(forKey: oldValue.keyPath)
      didChangeValue(forKey: state.keyPath)
    }
  }

  override var isReady: Bool {
    return super.isReady && state == .ready
  }

  override var isExecuting: Bool {
    return state == .executing
  }

  override var isFinished: Bool {
    return state == .finished
  }

  override var isAsynchronous: Bool {
    return true
  }

  // MARK: - Funcs

  override func start() {
    main()
    state = .executing
  }
}

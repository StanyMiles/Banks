//
//  Coordinator.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 18.10.2020.
//

import UIKit

protocol Coordinator {
  
  var childCoordinators: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }
  
  func start()
}

//
//  SceneDelegate.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 18.10.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  // MARK: - Properties
  
  var window: UIWindow?
  
  private var coordinator: MainCoordinator?

  // MARK: - Lifecycle
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    
    guard let scene = (scene as? UIWindowScene) else { return }
    
    setup(with: scene)
  }
  
  // MARK: - Funcs
  
  private func setup(with scene: UIWindowScene) {
    
    let navController = UINavigationController()
    let dataManager = DataManager()
    
    coordinator = MainCoordinator(
      navigationController: navController,
      dataManager: dataManager)
    
    guard let coordinator = coordinator else {
      fatalError("MainCoordinator MUST be instantiated at UIScene start")
    }
    
    coordinator.start()
    
    window = UIWindow(windowScene: scene)
    
    guard let window = window else {
      fatalError("UIWindow MUST be instantiated at UIScene start")
    }
    
    window.rootViewController = navController
    window.makeKeyAndVisible()
  }

}

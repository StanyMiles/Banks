//
//  AppDelegate.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 18.10.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  // MARK: - UISceneSession Lifecycle

  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    
    UISceneConfiguration(
      name: "Default Configuration",
      sessionRole: connectingSceneSession.role)
  }

}

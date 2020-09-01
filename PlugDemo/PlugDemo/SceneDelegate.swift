//
//  SceneDelegate.swift
//  PlugDemo
//
//  Created by projas on 8/31/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

    guard let windowScene = (scene as? UIWindowScene) else { return }
    self.window = UIWindow(windowScene: windowScene)
    self.window?.rootViewController = CampaignViewController()
    self.window?.makeKeyAndVisible()
  }
}


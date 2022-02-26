//
//  SceneDelegate.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let _ = UIWindow(windowScene: windowScene)
    
        if UserDefaults.standard.bool(forKey: "Logged") {
            showChatVC()
        }
    }
    
    func showChatVC() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Chat") as! ChatViewController
        let welcomeViewController = storyboard.instantiateViewController(withIdentifier: "Welcome") as! WelcomeViewController
        //viewController.view.backgroundColor = UIColor(named: Constants.BrandColors.purple)
        let navigationController = UINavigationController.init(rootViewController: welcomeViewController)
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .bold),NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController.navigationBar.barTintColor = UIColor(named: Constants.BrandColors.purple)
        navigationController.title = Constants.appName
        self.window?.rootViewController = navigationController
        navigationController.pushViewController(viewController, animated: true)
    }
}


//
//  AppDelegate.swift
//  ADIN
//
//  Created by Islam Temirbek on 9/27/16.
//  Copyright © 2016 Islam Temirbek. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.sharedManager().enable = true
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: WelcomeViewController())
        window?.makeKeyAndVisible()
        FirebaseApp.configure()
        coordinateAppFlow()
        return true
    }
}

extension AppDelegate {
    
    fileprivate func coordinateAppFlow() {
        window = UIWindow(frame: UIScreen.main.bounds).then {
            $0.backgroundColor = .white
        }
        if ((Auth.auth().currentUser) != nil) {
            loadMainPages()
        } else {
            loadLoginPages()
        }
    }
    
    func loadMainPages() {
        let mainTabBarController = MainTabBarController()
        window?.rootViewController = mainTabBarController
        window?.makeKeyAndVisible()
    }
    
    func loadLoginPages() {
        window?.rootViewController = UINavigationController(rootViewController: WelcomeViewController()).then {
            $0.navigationBar.tintColor = .black
            $0.navigationBar.barTintColor = .alabaster
        }
        window?.makeKeyAndVisible()
    }
}

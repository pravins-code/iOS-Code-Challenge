//
//  AppDelegate.swift
//  CodeChallenge
//
//  Created by Pravin Ghogare on 27/06/20.
//  Copyright © 2020 own. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Add Programmatically a Window and set a NavigationController with UIViewController
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainViewController = CCHomeScreenViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.navigationBar.tintColor = .green
        navigationController.navigationBar.backgroundColor = .green
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.barStyle = .default
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: AppDelegate Lifecycle

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
}


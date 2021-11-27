//
//  AppDelegate.swift
//  DIContainerExample
//
//  Created by Stas Kirichok on 07.10.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let coordinator = AppCoordinator(window: window)
        coordinator.start()
        
        return true
    }

}


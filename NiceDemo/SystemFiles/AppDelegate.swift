//
//  AppDelegate.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/4/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties
    
    var window: UIWindow?
    var appDelegateService: AppDelegateService!

    // MARK: UIApplication Delegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        appDelegateService = AppDelegateService(window: window)
        appDelegateService.setupAppCoordinator()
        self.window = window
        return true
    }
}


//
//  AppDelegate.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/4/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import UIKit

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Public properties
    
    var window: UIWindow?
    
    // MARK: Private properties
    
    private var appDelegateService: AppDelegateService!

    // MARK: UIApplication Delegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        appDelegateService = AppDelegateService(window: window!)
        appDelegateService.setupAppCoordinator()
        return true
    }
}


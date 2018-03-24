//
//  TestAppDelegate.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/21/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import UIKit

class TestAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        return true
    }
}

//
//  AppDelegateService.swift
//
//
//  Created by Serhii Kharauzov on 1/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

/// Responsible for handling all business logic, that should be established at AppDelegate.
class AppDelegateService {
    
    // MARK: Public properties
    
    /// root coordinator
    var appCoordinator: AppCoordinator!
    /// root window of the app
    let window: UIWindow
    
    // MARK: Init
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: Public methods
    
    func setupAppCoordinator() {
        window.rootViewController = BaseNavigationController()
        guard let rootNavigationController = window.rootViewController as? UINavigationController else {
            fatalError("Root viewController must be inherited from UINavigationController")
        }
        appCoordinator = AppCoordinator(navigationController: rootNavigationController)
        appCoordinator.start()
        window.makeKeyAndVisible()
    }
}

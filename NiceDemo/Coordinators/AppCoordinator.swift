//
//  AppCoordinator.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/5/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

/// Entry point among all coordinators.
/// Determines, what flow must be shown based on the rules.
class AppCoordinator: Coordinator {
    
    // MARK: Properties
    
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    // MARK: Public methods
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showStartScene()
        //showDogsFlow()
    }
    
    // MARK: Private methods
    
    private func showStartScene() {
        navigationController.pushViewController(StartConfigurator().configuredViewController(delegate: self), animated: false)
    }
    
    private func showAuthenticationFlow() {
        let authFlowCoordinator = AuthFlowCoordinator(navigationController: navigationController)
        authFlowCoordinator.delegate = self
        childCoordinators.append(authFlowCoordinator)
        authFlowCoordinator.start()
    }
    
    private func showDogsFlow() {
        let dogsFlowCoordinator = DogsFlowCoordinator(navigationController: navigationController)
        dogsFlowCoordinator.delegate = self
        childCoordinators.append(dogsFlowCoordinator)
        dogsFlowCoordinator.start()
    }
}

// MARK: StartPresenter Delegate

extension AppCoordinator: StartPresenterDelegate {
    func userNeedsToAuthenticate() {
        showAuthenticationFlow()
    }
    
    func userIsAuthenticated() {
        showDogsFlow()
    }
}

// MARK: AuthFlowCoordinator Delegate

extension AppCoordinator: AuthFlowCoordinatorDelegate {
    func userPerformedAuthentication() {
        showDogsFlow()
    }
}

// MARK: DogsFlowCoordinator Delegate

extension AppCoordinator: DogsFlowCoordinatorDelegate {
    
}

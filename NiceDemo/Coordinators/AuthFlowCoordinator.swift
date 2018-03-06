//
//  AuthFlowCoordinator.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/5/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

/// Responsible for auth flow in the project.
class AuthFlowCoordinator: Coordinator {
    
    // MARK: Properties
    
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    // MARK: Public methods
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showSignInScene()
    }
    
    // MARK: Private methods
    
    private func showSignInScene() {
        navigationController.setViewControllers([SignInConfigurator().configuredViewController(delegate: self)], animated: true)
    }
}

// MARK: SignInPresenter Delegate

extension AuthFlowCoordinator: SignInPresenterDelegate {
    func handleSignUpButtonTap() {
        
    }
    
    func handleForgotPasswordButtonTap() {
        
    }
    
    func userPerformedAuthentication() {
        
    }
}

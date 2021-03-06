//
//  AuthFlowCoordinator.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/5/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

protocol AuthFlowCoordinatorDelegate: class {
    func userPerformedAuthentication(coordinator: Coordinator)
}

/// Responsible for auth flow in the project.
class AuthFlowCoordinator: Coordinator {
    
    // MARK: Properties
    
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    weak var delegate: AuthFlowCoordinatorDelegate?
    
    // MARK: Public methods
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showSignInScene()
    }
    
    func showSignInScene() {
        navigationController.setViewControllers([SignInConfigurator().configuredViewController(delegate: self)], animated: true)
    }
    
    func showForgotPasswordScene() {
        navigationController.pushViewController(ForgotPasswordConfigurator().configuredViewController(delegate: self), animated: true)
    }
}

// MARK: SignIn scene delegate

extension AuthFlowCoordinator: SignInSceneDelegate {
    func handleSkipButtonTap() {
        userPerformedAuthentication()
    }
    
    func handleForgotPasswordButtonTap() {
        showForgotPasswordScene()
    }
    
    func userPerformedAuthentication() {
        delegate?.userPerformedAuthentication(coordinator: self)
    }
}

// MARK: ForgotPassword scene delegate

extension AuthFlowCoordinator: ForgotPasswordSceneDelegate {
    func userPerformedPasswordRecovery() {
        popViewController(animated: true)
    }
}

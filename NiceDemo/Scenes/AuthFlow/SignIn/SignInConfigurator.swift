//
//  SignInConfigurator.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/5/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

class SignInConfigurator {
    
    /// Returns viewController, configured with its associated presenter.
    func configuredViewController(delegate: SignInSceneDelegate?) -> SignInViewController {
        let viewController = SignInViewController()
        let presenter = SignInPresenter(view: viewController, userCredentialsStorage: UserCredentialsStorageService())
        presenter.delegate = delegate
        viewController.setPresenter(presenter)
        return viewController
    }
}

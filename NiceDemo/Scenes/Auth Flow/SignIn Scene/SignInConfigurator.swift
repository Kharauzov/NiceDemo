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
    func configuredViewController(delegate: SignInPresenterDelegate?) -> SignInViewController {
        let viewController = SignInViewController()
        let presenter = SignInPresenter(view: viewController)
        presenter.delegate = delegate
        viewController.setPresenter(presenter)
        return viewController
    }
}

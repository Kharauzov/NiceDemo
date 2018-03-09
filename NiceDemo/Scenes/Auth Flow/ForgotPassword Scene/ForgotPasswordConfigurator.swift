//
//  ForgotPasswordConfigurator.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

class ForgotPasswordConfigurator {
    
    /// Returns viewController, configured with its associated presenter.
    func configuredViewController(delegate: ForgotPasswordPresenterDelegate?) -> ForgotPasswordViewController {
        let viewController = ForgotPasswordViewController()
        let presenter = ForgotPasswordPresenter(view: viewController)
        presenter.delegate = delegate
        viewController.setPresenter(presenter)
        return viewController
    }
}

//
//  StartConfigurator.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/5/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

class StartConfigurator {
    
    /// Returns viewController, configured with its associated presenter.
    func configuredViewController(delegate: StartPresenterDelegate?) -> StartViewController {
        let viewController = StartViewController()
        let presenter = StartPresenter(view: viewController, userCredentialsStorage: UserCredentialsStorageService(storage: UserDefaultsLayer()))
        presenter.delegate = delegate
        viewController.setPresenter(presenter)
        return viewController
    }
}

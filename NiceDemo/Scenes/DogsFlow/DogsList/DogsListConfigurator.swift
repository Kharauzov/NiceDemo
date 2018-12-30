//
//  DogsListConfigurator.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

class DogsListConfigurator {
    
    /// Returns viewController, configured with its associated presenter.
    func configuredViewController(delegate: DogsListSceneDelegate?) -> DogsListViewController {
        let viewController = DogsListViewController()
        let presenter = DogsListPresenter(view: viewController)
        presenter.delegate = delegate
        viewController.setPresenter(presenter)
        return viewController
    }
}

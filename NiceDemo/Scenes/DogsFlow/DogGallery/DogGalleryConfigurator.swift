//
//  DogGalleryConfigurator.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/15/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

class DogGalleryConfigurator {
    
    /// Returns viewController, configured with its associated presenter.
    func configuredViewController(dog: Dog, delegate: DogsGallerySceneDelegate?) -> DogGalleryViewController {
        let viewController = DogGalleryViewController()
        let presenter = DogGalleryPresenter(view: viewController, dog: dog)
        presenter.delegate = delegate
        viewController.setPresenter(presenter)
        return viewController
    }
}

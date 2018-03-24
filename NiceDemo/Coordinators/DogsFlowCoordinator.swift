//
//  DogsFlowCoordinator.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

protocol DogsFlowCoordinatorDelegate: class {

}

/// Responsible for dogs flow in the project.
class DogsFlowCoordinator: Coordinator {
    
    // MARK: Properties
    
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    weak var delegate: DogsFlowCoordinatorDelegate?
    
    // MARK: Public methods
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showDogsListScene()
    }
    
    func showDogsListScene() {
        navigationController.setViewControllers([DogsListConfigurator().configuredViewController(delegate: self)], animated: true)
    }
    
    func showDogGalleryScene(dogBreed: String) {
        navigationController.pushViewController(DogGalleryConfigurator().configuredViewController(breed: dogBreed, delegate: self), animated: true)
    }
}

// MARK: DogsList scene delegate

extension DogsFlowCoordinator: DogsListSceneDelegate {
    func didSelectDog(_ dog: Dog) {
        showDogGalleryScene(dogBreed: dog.breed)
    }
}

// MARK: DogGallery scene delegate

extension DogsFlowCoordinator: DogsGallerySceneDelegate {
    
}

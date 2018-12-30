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
    
    func showDogGalleryScene(dog: Dog) {
        navigationController.pushViewController(getDogGallerySceneFrom(dog: dog), animated: true)
    }
    
    func getDogGallerySceneFrom(dog: Dog) -> UIViewController {
        return DogGalleryConfigurator().configuredViewController(dog: dog, delegate: self)
    }
}

// MARK: DogsList scene delegate

extension DogsFlowCoordinator: DogsListSceneDelegate {
    func getGalleryView(for dog: Dog) -> UIViewController {
        let dogGalleryViewController = getDogGallerySceneFrom(dog: dog)
        // we return scene wrapped at `UINavigationController` in order to show
        // navigation bar at preview of Peek&Pop functional
        return UINavigationController(rootViewController: dogGalleryViewController)
    }
    
    func didSelectDog(_ dog: Dog) {
        showDogGalleryScene(dog: dog)
    }
}

// MARK: DogGallery scene delegate

extension DogsFlowCoordinator: DogsGallerySceneDelegate {
    
}

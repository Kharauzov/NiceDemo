//
//  Coordinator.swift
//  
//
//  Created by Serhii Kharauzov on 1/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get }
    
    func start()
    func addChildCoordinator(_ coordinator: Coordinator)
    func removeChildCoordinator(_ coordinator: Coordinator)
}

extension Coordinator {
    func addChildCoordinator(_ coordinator: Coordinator) {
        for element in childCoordinators {
            if element === coordinator {
                return
            }
        }
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        guard !childCoordinators.isEmpty else { return }
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

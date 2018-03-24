//
//  AppCoordinatorTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 3/23/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: AppCoordinator
///

class AppCoordinatorTests: XCTestCase {

    var coordinator: AppCoordinator!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coordinator = AppCoordinator(navigationController: UINavigationController())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        coordinator = nil
        super.tearDown()
    }
    
    func testStartMethod() {
        // when
        coordinator.start()
        // then
        XCTAssertFalse(coordinator.navigationController.viewControllers.isEmpty, "Coordinator's navigationController must not be empty after `start` method call.")
    }
    
    func testShowDogFlow() {
        // when
        coordinator.showDogsFlow()
        // then
        XCTAssertFalse(coordinator.childCoordinators.isEmpty, "Coordinator's childControllers must have value.")
        XCTAssertTrue(coordinator.navigationController.visibleViewController is DogsListViewController, "Visible viewcontroller must be of class `DogsListViewController`")
    }
    
    func testShowAuthFlow() {
        // when
        coordinator.showAuthenticationFlow()
        // then
        XCTAssertFalse(coordinator.childCoordinators.isEmpty, "Coordinator's childControllers must have value.")
        XCTAssertTrue(coordinator.navigationController.visibleViewController is SignInViewController, "Visible viewcontroller must be of class `SignInViewController`")
    }
}

//
//  DogsFlowCoordinatorTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 3/23/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: DogsFlowCoordinator
///

class DogsFlowCoordinatorTests: XCTestCase {
    
    var coordinator: DogsFlowCoordinator!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coordinator = DogsFlowCoordinator(navigationController: UINavigationController())
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
    
    func testShowDogsListScene() {
        // when
        coordinator.showDogsListScene()
        // then
        XCTAssertTrue(coordinator.navigationController.visibleViewController is DogsListViewController, "Visible viewcontroller must be of class `DogsListViewController`")
    }
    
    func testShowDogGalleryScene() {
        // when
        let dog = Dog(breed: "", subbreeds: [])
        coordinator.showDogGalleryScene(dog: dog)
        // then
        XCTAssertTrue(coordinator.navigationController.visibleViewController is DogGalleryViewController, "Visible viewcontroller must be of class `DogGalleryViewController`")
    }
}


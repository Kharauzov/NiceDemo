//
//  CoordinatorTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 3/23/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

/// Created for testing of Coordinator's protocol default implementation in extension.
class MockCoordinator: Coordinator {
    
    // MARK: Properties
    
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    // MARK: Public methods
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.setViewControllers([MockViewController()], animated: false)
    }
}

/// Created for testing of Coordinator's protocol default implementation in extension.
class MockViewController: BaseViewController {
}

///
/// SUT: MockCoordinator
///

class CoordinatorTests: XCTestCase {
    
    var coordinator: MockCoordinator!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coordinator = MockCoordinator()
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
    
    func testChildCoordinatorsCollection() {
        let testCoordinator = MockCoordinator()
        // when
        coordinator.addChildCoordinator(testCoordinator)
        // then
        XCTAssertNotNil(coordinator.childCoordinators.filter({$0 === testCoordinator}).first, "Added `testCoordiantor` must exists at childCoordinators collection.")
        // when
        coordinator.addChildCoordinator(testCoordinator)
        // then
        XCTAssertEqual(coordinator.childCoordinators.count, 1, "Added `testCoordiantor` must still exists in single form.")
        // when
        coordinator.removeChildCoordinator(testCoordinator)
        // then
        XCTAssertNil(coordinator.childCoordinators.filter({$0 === testCoordinator}).first, "Removed `testCoordiantor` must not exists at childCoordinators collection.")
    }
    
    func testPop() {
        // when
        // we added `MockViewController` as second item in collection due to possibility
        // performing `popViewController` under it at UINavigationController
        let mockViewController = MockViewController()
        coordinator.navigationController.setViewControllers([UIViewController(), mockViewController], animated: false)
        // then
        XCTAssertNotNil(coordinator.navigationController.viewControllers.filter({$0 === mockViewController}).first, "`MockViewController` must exists at navigationController.viewControllers collection after `start` call.")
        // when
        coordinator.popViewController(animated: false)
        // then
        XCTAssertNil(coordinator.navigationController.viewControllers.filter({$0 === mockViewController}).first, "`MockViewController` must not exists at navigationController.viewControllers collection after `pop` call.")
    }
    
    func testDismiss() {
        // when
        UIApplication.shared.delegate?.window??.rootViewController = coordinator.navigationController
        UIApplication.shared.delegate?.window??.makeKeyAndVisible()
        coordinator.navigationController.setViewControllers([UIViewController()], animated: false)
        let mockViewController = MockViewController()
        coordinator.navigationController.present(mockViewController, animated: false, completion: nil)
        // then
        XCTAssertTrue(coordinator.navigationController.presentedViewController === mockViewController, "PresentedViewController must be `MockViewController`")
        // when
        let promise = expectation(description: "Completion handler invoked")
        coordinator.dismissViewController(animated: false) {
            promise.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        // then
        XCTAssertNil(coordinator.navigationController.presentedViewController, "PresentedViewController must be nil")
    }
}

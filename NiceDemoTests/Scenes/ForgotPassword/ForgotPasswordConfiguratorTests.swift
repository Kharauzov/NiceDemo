//
//  ForgotPasswordConfiguratorTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 1/24/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: ForgotPasswordConfigurator
///

class ForgotPasswordConfiguratorTests: XCTestCase {
    
    var configurator: ForgotPasswordConfigurator!
    
    func testConfiguratorBuildResult() {
        // when
        configurator = ForgotPasswordConfigurator()
        let configuredViewController = configurator.configuredViewController(delegate: nil)
        // then
        XCTAssertNotNil(configuredViewController.presenter, "Presenter should be coupled to viewController")
    }
}

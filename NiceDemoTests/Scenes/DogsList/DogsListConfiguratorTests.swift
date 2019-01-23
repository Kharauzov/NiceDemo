//
//  DogsListConfiguratorTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 1/20/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: DogsListConfigurator
///

class DogsListConfiguratorTests: XCTestCase {
    
    var configurator: DogsListConfigurator!
    
    func testConfiguratorBuildResult() {
        // when
        configurator = DogsListConfigurator()
        let configuredViewController = configurator.configuredViewController(delegate: nil)
        // then
        XCTAssertNotNil(configuredViewController.presenter, "Presenter should be coupled to viewController")
    }
}


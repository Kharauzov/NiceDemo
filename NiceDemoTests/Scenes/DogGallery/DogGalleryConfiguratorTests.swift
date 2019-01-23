//
//  DogGalleryConfiguratorTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 1/20/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: DogGalleryConfigurator
///

class DogGalleryConfiguratorTests: XCTestCase {
    
    var configurator: DogGalleryConfigurator!
    
    func testConfiguratorBuildResult() {
        // when
        configurator = DogGalleryConfigurator()
        let dog = Dog(breed: "", subbreeds: [])
        let configuredViewController = configurator.configuredViewController(dog: dog, delegate: nil)
        // then
        XCTAssertNotNil(configuredViewController.presenter, "Presenter should be coupled to viewController")
    }
}


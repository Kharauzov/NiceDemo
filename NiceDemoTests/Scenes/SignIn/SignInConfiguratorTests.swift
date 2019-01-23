//
//  SignInConfiguratorTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 3/21/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT - SignInConfigurator
///

class SignInConfiguratorTests: XCTestCase {
    
    var signInConfigurator: SignInConfigurator!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        signInConfigurator = SignInConfigurator()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        signInConfigurator = nil
        super.tearDown()
    }
    
    func testCorrectSceneBindings() {
        // when
        let viewController = signInConfigurator.configuredViewController(delegate: nil)
        // then
        XCTAssertNotNil(viewController.presenter, "ViewController's presenter must be not nil after bindings.")
    }
}

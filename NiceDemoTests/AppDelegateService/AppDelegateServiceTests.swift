//
//  AppDelegateServiceTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 3/24/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: AppDelegateService
///

class AppDelegateServiceTests: XCTestCase {
    
    var appDelegateService: AppDelegateService!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        appDelegateService = AppDelegateService(window: UIWindow(frame: .zero))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        appDelegateService = nil
        super.tearDown()
    }
    
    func testSetupAppCoordinator() {
        // when
        appDelegateService.setupAppCoordinator()
        // then
        XCTAssertNotNil(appDelegateService.window.rootViewController, "RootViewController is nil after setup.")
        XCTAssertTrue(appDelegateService.window.isKeyWindow, "Window is not key after setup.")
        XCTAssertNotNil(appDelegateService.appCoordinator, "AppCoordinator is nil after setup.")
    }
}

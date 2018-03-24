//
//  SignInSceneTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 3/21/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: SignInScene: SignInViewController, SignInView, SignInPresenter
///

/// Used for testing purpose only.
class MockUserDefaultsLayer: UserDefaultsLayer {
    override init(userDefaultsSuiteName: String?) {
        if let name = userDefaultsSuiteName {
            // removing the persistent domain for suit name
            UserDefaults().removePersistentDomain(forName: name)
        }
        super.init(userDefaultsSuiteName: userDefaultsSuiteName)
    }
}

class SignInSceneTests: XCTestCase {
    
    var viewController: SignInViewController!
    var presenter: SignInPresenter!
    var customView: SignInView!
    var userCredentialsStorageService: UserCredentialsStorageService!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // MVP bingings
        userCredentialsStorageService = UserCredentialsStorageService(storage: MockUserDefaultsLayer(userDefaultsSuiteName: "TestUserDefaultsLayer"))
        userCredentialsStorageService.isUserAuthenticated = false
        viewController = SignInViewController()
        presenter = SignInPresenter(view: viewController, userCredentialsStorage: userCredentialsStorageService)
        viewController.setPresenter(presenter)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        presenter = nil
        customView = nil
        userCredentialsStorageService = nil
        super.tearDown()
    }
    
    /// Testing correct credentials on input.
    func testUserCredentialsFieldIsUpdatedAfterSuccessfulAuthentication() {
        // when
        viewController.setEmailText("test@test.com") // correct format
        viewController.setPasswordText("123456") // correct format
        presenter.handleSignInButtonTap()
        // then
        XCTAssertTrue(userCredentialsStorageService.isUserAuthenticated, "Must be true, as user's credentials are correct.")
    }
    
    /// Testing wrong credentials on input.
    func testUserCredentialsFieldIsUpdatedAfterFailedAuthentication() {
        // when
        viewController.setEmailText("wrong_email") // uncorrect format
        viewController.setPasswordText("123") // uncorrect format
        presenter.handleSignInButtonTap()
        // then
        XCTAssertFalse(userCredentialsStorageService.isUserAuthenticated, "Must be false, as user's credentials are incorrect.")
    }
    
}


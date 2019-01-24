//
//  ForgotPasswordPresenterTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 1/24/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: ForgotPasswordPresenter
///

class ForgotPasswordPresenterTests: XCTestCase {
    
    var presenter: ForgotPasswordPresenter!
    var viewController: ForgotPasswordViewControllerMock!
    var delegate: ForgotPasswordSceneDelegateMock!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = ForgotPasswordViewControllerMock()
        presenter = ForgotPasswordPresenter(view: viewController)
        delegate = ForgotPasswordSceneDelegateMock()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        presenter = nil
        delegate = nil
    }
    
    func testHandleSubmitButtonTapWithCorrectEmail() {
        // given
        viewController.emailStub = "test@email.com"
        presenter.delegate = delegate
        // when
        presenter.handleSubmitButtonTap()
        // then
        XCTAssertEqual(delegate.isUserPerformedPasswordRecovery, true)
    }
    
    func testHandleSubmitButtonTapWithIncorrectEmail() {
        // given
        viewController.emailStub = "test_email.com"
        presenter.delegate = delegate
        // when
        presenter.handleSubmitButtonTap()
        // then
        XCTAssertEqual(delegate.isUserPerformedPasswordRecovery, false)
    }
    
    func testKeyboardAppearanceOnSubmitButtonTap() {
        // given
        viewController.isKeyboardPresented = true
        // when
        presenter.handleSubmitButtonTap()
        // then
        XCTAssertEqual(viewController.isKeyboardPresented, false)
    }
}

class ForgotPasswordViewControllerMock: ForgotPasswordViewInterface {
    var emailStub: String?
    var isKeyboardPresented = false
    
    func hideKeyboard() {
        isKeyboardPresented = false
    }
    
    func getEmailText() -> String? {
        return emailStub
    }
    
    func showAlert(title: String?, message: String?, completion: (() -> Void)?) {
        completion?()
    }
}

class ForgotPasswordSceneDelegateMock: ForgotPasswordSceneDelegate {
    var isUserPerformedPasswordRecovery = false
    
    func userPerformedPasswordRecovery() {
        isUserPerformedPasswordRecovery = true
    }
}

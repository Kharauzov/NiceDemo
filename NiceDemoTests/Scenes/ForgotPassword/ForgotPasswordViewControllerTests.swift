//
//  ForgotPasswordViewControllerTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 18.04.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: ForgotPasswordViewController
///

class ForgotPasswordViewControllerTests: XCTestCase {

    var viewController: ForgotPasswordViewController!
    var presenter: MockForgotPasswordPresenter!
    
    override func setUp() {
        presenter = MockForgotPasswordPresenter()
        viewController = ForgotPasswordViewController()
        viewController.presenter = presenter
        _ = viewController.view
    }
    
    override func tearDown() {
        viewController = nil
    }
    
    func testSetPresenter() {
        let testPresenter = MockForgotPasswordPresenter()
        viewController.setPresenter(testPresenter)
        XCTAssertTrue(testPresenter === viewController.presenter)
    }
    
    func testViewDidLoad() {
        // assuming, that viewDidLoad() was called
        // due to line `_ = viewController.view`
        
        // when
        viewController.customView.didPressSubmitButton?()
        
        // then
        XCTAssertNotNil(viewController.customView.didPressSubmitButton)
        XCTAssertEqual(viewController.navigationItem.title, "Recover password")
        XCTAssertEqual(presenter.handleSubmitButtonTapCounter, 1)
    }
    
    func testGetEmailText() {
        // given
        let text = "email"
        viewController.customView.emailTextField.text = text
        // when
        let fetchedText = viewController.getEmailText()
        // then
        XCTAssertEqual(text, fetchedText)
    }
}

class MockForgotPasswordPresenter: ForgotPasswordPresentation {
    var handleSubmitButtonTapCounter = 0
    
    func handleSubmitButtonTap() {
        handleSubmitButtonTapCounter += 1
    }
}

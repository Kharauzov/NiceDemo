//
//  ValidatorTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 3/23/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: Validator
///

class ValidatorTests: XCTestCase {
    
    var validator: Validator!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        validator = Validator()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        validator = nil
        super.tearDown()
    }
    
    func testCorrectValidationOfEmail() {
        // when
        XCTAssertThrowsError(try validator.validateEmail("wrongEmail")) { error in
            // then
            XCTAssertEqual(error as? Validator.ValidationError, Validator.ValidationError.emailFormatIsWrong, "")
        }
        
        // when
        XCTAssertThrowsError(try validator.validateEmail(nil)) { error in
            // then
            XCTAssertEqual(error as? Validator.ValidationError, Validator.ValidationError.valueIsEmpty("Email"), "")
        }
        
        // when
        XCTAssertThrowsError(try validator.validateEmail("")) { error in
            // then
            XCTAssertEqual(error as? Validator.ValidationError, Validator.ValidationError.valueIsEmpty("Email"), "")
        }
        
        // when
        // then
        XCTAssertNoThrow(try validator.validateEmail("test@gmail.com"))
    }
    
    func testCorrectValidationOfPassword() {
        // when
        XCTAssertThrowsError(try validator.validatePassword("111")) { error in
            // then
            XCTAssertEqual(error as? Validator.ValidationError, Validator.ValidationError.passwordLengthIsWrong, "")
        }
        
        // when
        XCTAssertThrowsError(try validator.validatePassword(nil)) { error in
            // then
            XCTAssertEqual(error as? Validator.ValidationError, Validator.ValidationError.valueIsEmpty("Password"), "")
        }
        
        // when
        XCTAssertThrowsError(try validator.validatePassword("")) { error in
            // then
            XCTAssertEqual(error as? Validator.ValidationError, Validator.ValidationError.valueIsEmpty("Password"), "")
        }
        
        // when
        // then
        XCTAssertNoThrow(try validator.validatePassword("goodPassword"))
    }
}

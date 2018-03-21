//
//  NiceDemoNetworkTests.swift
//  NiceDemoNetworkTests
//
//  Created by Serhii Kharauzov on 3/19/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

class NiceDemoNetworkTests: XCTestCase {
    
    var dogsServerService: DogsServerService!
    
    override func setUp() {
        super.setUp()
        dogsServerService = DogsServerService(core: UrlSessionService())
    }
    
    override func tearDown() {
        dogsServerService = nil
        super.tearDown()
    }
   
    func testGetAllDogsNetworkRequest() {
        // given
        let promise = expectation(description: "Completion handler invoked")
        var responseData: Any?
        var responseError: Error?
        // when
        dogsServerService.getAllDogs { (dogs, error) in
            responseData = dogs
            responseError = error
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        // then
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseData)
    }
    
    func testGetDogRandomImageUrl() {
        // given
        let promise = expectation(description: "Completion handler invoked")
        var responseData: Any?
        var responseError: Error?
        // when
        dogsServerService.getDogRandomImageUrl(breed: "akita") { (urlString, error) in
            responseData = urlString
            responseError = error
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        // then
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseData)
    }
    
}

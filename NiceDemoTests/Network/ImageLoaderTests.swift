//
//  ImageLoaderTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 3/23/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: SimpleImageLoader
///

class ImageLoaderTests: XCTestCase {
    
    var imageLoader: SimpleImageLoader!
    var imageLoaderCore: MockImageLoaderCore!
    
    override func setUp() {
        super.setUp()
        imageLoaderCore = MockImageLoaderCore()
        imageLoader = SimpleImageLoader(core: imageLoaderCore)
    }
    
    override func tearDown() {
        imageLoader = nil
        imageLoaderCore = nil
        super.tearDown()
    }
    
    func testLoadingOfImageByValidUrl() {
        // given
        var responseData: Any?
        let validUrlString = "https://mock.com/valid.jpg"
        let promise = expectation(description: "Completion handler invoked")
        // when
        imageLoader.loadImageFrom(urlString: validUrlString) { (image) in
            responseData = image
            promise.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        // then
        XCTAssertNotNil(responseData)
    }
    
    func testLoadingOfImageByInvalidUrl() {
        // given
        var responseData: Any?
        let notValidUrlString = ""
        let promise = expectation(description: "Completion handler invoked")
        // when
        imageLoader.loadImageFrom(urlString: notValidUrlString) { (image) in
            responseData = image
            promise.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        // then
        XCTAssertNil(responseData)
    }
}

class MockImageLoaderCore: ImageLoaderCore {
    func getData(from url: URL) -> Data? {
        return #imageLiteral(resourceName: "dog").pngData()
    }
}

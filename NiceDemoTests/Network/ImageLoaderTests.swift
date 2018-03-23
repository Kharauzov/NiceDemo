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
    
    override func setUp() {
        super.setUp()
        imageLoader = SimpleImageLoader()
    }
    
    override func tearDown() {
        imageLoader = nil
        super.tearDown()
    }
    
    func testLoadingOfImageByUrl() {
        // given
        let promise = expectation(description: "Completion handler invoked")
        var responseData: Any?
        // when
        imageLoader.loadImageFrom(urlString: "https://dog.ceo/api/img/hound-walker/n02089867_1381.jpg") { (image) in
            responseData = image
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        // then
        XCTAssertNotNil(responseData)
    }
}

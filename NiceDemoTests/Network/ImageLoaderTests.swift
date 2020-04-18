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
        // when
        imageLoader.loadImageFrom(urlString: validUrlString) { (image) in
            responseData = image
        }
        // then
        XCTAssertNotNil(responseData)
    }
    
    func testLoadingOfImageByInvalidUrl() {
        // given
        var responseData: Any?
        let notValidUrlString = ""
        // when
        imageLoader.loadImageFrom(urlString: notValidUrlString) { (image) in
            responseData = image
        }
        // then
        XCTAssertNil(responseData)
    }
}

class MockImageLoaderCore: ImageLoaderCore {
    func getImageData(from url: URL, completion: @escaping (_ data: Data?) -> Void) {
        completion(#imageLiteral(resourceName: "dog").pngData())
    }
}

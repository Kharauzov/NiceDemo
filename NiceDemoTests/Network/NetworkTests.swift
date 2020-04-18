//
//  NetworkTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 3/21/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: DogsServerService
///

class NiceDemoNetworkTests: XCTestCase {
    
    var dogsServerService: DogsServerService!
    var dogsDataParser: MockDogsApiDataParser!
    var core: MockServerService!
    
    override func setUp() {
        super.setUp()
        dogsDataParser = MockDogsApiDataParser()
        core = MockServerService()
        dogsServerService = DogsServerService(core: core, parser: dogsDataParser)
    }
    
    override func tearDown() {
        dogsServerService = nil
        super.tearDown()
    }
    
    func testGetAllDogsValidNetworkRequest() {
        // given
        var responseData: Any?
        var responseError: Error?
        let getAllDogsUrlPath = ServerRouter.getAllDogsBreeds.asURLRequest().url?.absoluteString
        // when
        dogsServerService.getAllDogs { (dogs, error) in
            responseData = dogs
            responseError = error
        }
        // then
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseData)
        XCTAssertEqual(getAllDogsUrlPath, core.requestUrlString)
    }
    
    func testGetAllDogsNotValidNetworkRequest() {
        // given
        var responseData: Any?
        var responseError: Error?
        let getAllDogsUrlPath = ServerRouter.getAllDogsBreeds.asURLRequest().url?.absoluteString
        core.shouldFailRequest = true
        // when
        dogsServerService.getAllDogs { (dogs, error) in
            responseData = dogs
            responseError = error
        }
        // then
        XCTAssertNotNil(responseError)
        XCTAssertNil(responseData)
        XCTAssertEqual(getAllDogsUrlPath, core.requestUrlString)
    }
    
    func testGetDogRandomImageValidUrlRequest() {
        // given
        var responseData: Any?
        var responseError: Error?
        let breed = "akita"
        let getDogRandomImageUrlPath = ServerRouter.getDogRandomImage(breed).asURLRequest().url?.absoluteString
        // when
        dogsServerService.getDogRandomImageUrl(breed: breed) { (urlString, error) in
            responseData = urlString
            responseError = error
        }
        // then
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseData)
        XCTAssertEqual(getDogRandomImageUrlPath, core.requestUrlString)
    }
    
    func testGetDogRandomImageNotValidUrlRequest() {
        // given
        var responseData: Any?
        var responseError: Error?
        let breed = "akita"
        let getDogRandomImageUrlPath = ServerRouter.getDogRandomImage(breed).asURLRequest().url?.absoluteString
        core.shouldFailRequest = true
        // when
        dogsServerService.getDogRandomImageUrl(breed: breed) { (urlString, error) in
            responseData = urlString
            responseError = error
        }
        // then
        XCTAssertNotNil(responseError)
        XCTAssertNil(responseData)
        XCTAssertEqual(getDogRandomImageUrlPath, core.requestUrlString)
    }
}

class MockServerService: ServerService {
    var requestUrlString: String?
    var shouldFailRequest = false
    
    func performRequest<T>(_ request: URLRequestable, completion: ServerRequestResponseCompletion<T>?) {
        requestUrlString = request.asURLRequest().url?.absoluteString
        if shouldFailRequest {
            completion?(Result.failure(NSError(domain: "", code: 0, userInfo: nil)))
        } else if let data = Data() as? T {
            completion?(Result.success(data))
        }
    }
}

class MockDogsApiDataParser: DogsServerResponseParser {
    func parseGetAllDogsResponse(data: Data) -> [Dog]? {
        return [Dog(breed: "Test", subbreeds: nil)]
    }
    
    func parseGetDogRandomImageUrlResponse(data: Data) -> String? {
        return "image.jpg"
    }
}

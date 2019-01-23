//
//  DogGallerySceneTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 1/20/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: DogGalleryViewController, DogGalleryPresenter
///

class DogGallerySceneTests: XCTestCase {
    
    var viewController: DogGalleryViewController!
    var presenter: DogGalleryPresenter!
    let dog = Dog(breed: "Akita", subbreeds: ["Subbreed1", "Subbreed2", "Subbreed3"])
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = DogGalleryViewController()
        presenter = DogGalleryPresenter(view: viewController, dog: dog)
        viewController.setPresenter(presenter)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        presenter = nil
    }
    /*
    func testLoadingRandomImageViewState() {
        // when
        _ = viewController.view // cause viewDidLoad() call
        // TODO: test with mock dogsServerService
        // then
        XCTAssertNotNil(HUDView.hudIn(view: viewController.customView.containerView), "HUD should appear when image is loading.")
    }
    
    func testResultRandomImageViewState() {
        // when
        XCTAssertNil(viewController.customView.setDogImage(<#T##image: UIImage##UIImage#>))
        let testImage = #imageLiteral(resourceName: "pawPrintNotSelected")
        presenter.updateViewBasedOn(state: .resultRandomImage(testImage))
        // then
        XCTAssertNil(HUDView.hudIn(view: viewController.customView.containerView), "HUD should disappear when image is loaded.")
        
    }
     */
}


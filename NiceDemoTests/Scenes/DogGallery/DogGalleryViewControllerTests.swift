//
//  DogGalleryViewControllerTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 18.04.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: DogGalleryViewController
///

class DogGalleryViewControllerTests: XCTestCase {

    var viewController: DogGalleryViewController!
    var presenter: MockDogGalleryPresenter!
    
    override func setUp() {
        presenter = MockDogGalleryPresenter()
        viewController = DogGalleryViewController()
        viewController.setPresenter(presenter)
        _ = viewController.view
    }
    
    override func tearDown() {
        viewController = nil
    }

    func testSetPresenter() {
        let testPresenter = MockDogGalleryPresenter()
        viewController.setPresenter(testPresenter)
        XCTAssertTrue(testPresenter === viewController.presenter)
    }
    
    func testViewDidLoad() {
        // assuming, that viewDidLoad() was called
        // due to line `_ = viewController.view`
        
        // when
        viewController.customView.didPressActionButton?()
        
        // then
        XCTAssertNotNil(viewController.customView.didPressActionButton)
        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
        XCTAssertEqual(presenter.onViewDidLoadCounter, 1)
        XCTAssertEqual(presenter.handleActionButtonTapCounter, 1)
    }
    
    func testFavouriteButtonTap() {
        // given
        XCTAssertEqual(presenter.handleFavouriteButtonTapCounter, 0)
        // when
        viewController.favouriteButtonTapped()
        // then
        XCTAssertEqual(presenter.handleFavouriteButtonTapCounter, 1)
    }
    
    func testSetCollectionViewProvider() {
        // given
        XCTAssertNil(viewController.customView.collectionView.dataSource)
        XCTAssertNil(viewController.customView.collectionView.delegate)
        // when
        let collectionViewProvider = DogBreedsCollectionViewProvider()
        viewController.setCollectionViewProvider(collectionViewProvider)
        // then
        XCTAssertNotNil(viewController.customView.collectionView.dataSource)
        XCTAssertNotNil(viewController.customView.collectionView.delegate)
    }
    
    func testSetDogImage() {
        // given
        XCTAssertNil(viewController.customView.dogImageView.image)
        let image = #imageLiteral(resourceName: "dog")
        // when
        viewController.setDogImage(image, animated: false)
        // then
        XCTAssertEqual(image, viewController.customView.dogImageView.image)
    }
    
    func testSetNavigationTitle() {
        // given
        XCTAssertNil(viewController.navigationItem.title)
        let title = "test"
        // when
        viewController.setNavigationTitle(title)
        // then
        XCTAssertEqual(title, viewController.navigationItem.title)
    }
    
    func testShowHUD() {
        // given
        XCTAssertNil(HUDView.hudIn(view: viewController.customView.containerView))
        // when
        viewController.showHUD(animated: false)
        // then
        XCTAssertNotNil(HUDView.hudIn(view: viewController.customView.containerView))
    }
    
    func testHideHUD() {
        // given
        viewController.showHUD(animated: false)
        XCTAssertNotNil(HUDView.hudIn(view: viewController.customView.containerView))
        // when
        viewController.hideHUD(animated: false)
        // then
        XCTAssertNil(HUDView.hudIn(view: viewController.customView.containerView))
    }
    
    func testSetRightBarButtonItemHighlightState() {
        // when
        viewController.setRightBarButtonItemHighlightState(true, animated: false)
        // then
        XCTAssertEqual(viewController.navigationItem.rightBarButtonItem?.image, #imageLiteral(resourceName: "pawPrintSelected").withRenderingMode(.alwaysTemplate))
        
        // when
        viewController.setRightBarButtonItemHighlightState(false, animated: false)
        // then
        XCTAssertEqual(viewController.navigationItem.rightBarButtonItem?.image, #imageLiteral(resourceName: "pawPrintNotSelected").withRenderingMode(.alwaysTemplate))
        
        // when
        viewController.navigationItem.rightBarButtonItem = nil
        viewController.setRightBarButtonItemHighlightState(false, animated: false)
        // then
        XCTAssertNil(viewController.navigationItem.rightBarButtonItem?.image)
    }
    
    func testShowNoDataLabel() {
        // given
        viewController.hideNoDataLabel()
        XCTAssertTrue(viewController.customView.noDataLabel.isHidden)
        // when
        viewController.showNoDataLabel()
        // then
        XCTAssertFalse(viewController.customView.noDataLabel.isHidden)
    }
}

class MockDogGalleryPresenter: DogGalleryPresentation {
    var onViewDidLoadCounter = 0
    var handleActionButtonTapCounter = 0
    var handleFavouriteButtonTapCounter = 0
    
    func onViewDidLoad() {
        onViewDidLoadCounter += 1
    }
    
    func handleActionButtonTap() {
        handleActionButtonTapCounter += 1
    }
    
    func handleFavouriteButtonTap() {
        handleFavouriteButtonTapCounter += 1
    }
}

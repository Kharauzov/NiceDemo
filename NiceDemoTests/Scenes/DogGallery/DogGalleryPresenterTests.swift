//
//  DogGalleryPresenterTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 1/24/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: DogGalleryPresenter
///

class DogGalleryPresenterTests: XCTestCase {
    
    var viewController: DogGalleryViewControllerMock!
    var presenter: DogGalleryPresenter!
    var serverService: DogGalleryServerServiceMock!
    var storageService: DogGalleryStorageServiceMock!
    var imageLoader: ImageLoaderMock!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = DogGalleryViewControllerMock()
        serverService = DogGalleryServerServiceMock()
        storageService = DogGalleryStorageServiceMock()
        imageLoader = ImageLoaderMock()
        presenter = DogGalleryPresenter(view: viewController, dog: Dog(breed: "", subbreeds: []), serverService: serverService, storageService: storageService, imageLoader: imageLoader)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        presenter = nil
    }
    
    func testLoadingRandomImageViewState() {
        // given
        serverService.testCompletionResult = "some real url"
        // when
        XCTAssertEqual(imageLoader.loadImageFromDidCalled, 0)
        XCTAssertEqual(serverService.getDogRandomImageUrlDidCalled, 0)
        presenter.updateViewBasedOn(state: .loadingRandomImage)
        // then
        XCTAssertEqual(imageLoader.loadImageFromDidCalled, 1)
        XCTAssertEqual(serverService.getDogRandomImageUrlDidCalled, 1)
    }
    
    func testResultRandomImageViewState() {
        // when
        viewController.showHUD(animated: true)
        XCTAssertEqual(viewController.isDogImageSet, false)
        XCTAssertEqual(viewController.isHudDisplayed, true)
        let resultImgae = #imageLiteral(resourceName: "pawPrintSelected")
        presenter.updateViewBasedOn(state: .resultRandomImage(resultImgae))
        // then
        XCTAssertEqual(viewController.isDogImageSet, true)
        XCTAssertEqual(viewController.isHudDisplayed, false)
    }
    
    func testErrorGettingRandomImage() {
        // when
        viewController.showHUD(animated: true)
        XCTAssertEqual(viewController.isHudDisplayed, true)
        presenter.updateViewBasedOn(state: .errorGettingRandomImage(message: ""))
        // then
        XCTAssertEqual(viewController.isHudDisplayed, false)
    }
    
    func testHandleFavouriteButtonTap() {
        // given
        storageService.favouriteDogBreedStub = nil
        
        // when
        presenter.handleFavouriteButtonTap()
        // then
        XCTAssertEqual(viewController.isRightBarButtonHighlighted, true)
        
        // when
        presenter.handleFavouriteButtonTap()
        // then
        XCTAssertEqual(viewController.isRightBarButtonHighlighted, false)
    }
    
    func testShowDogSubbreeds() {
        // given
        let testSubbreeds = ["Breed #1", "Breed #2"]
        // when
        presenter.showDogSubbreeds(testSubbreeds)
        // then
        XCTAssertEqual(presenter.collectionViewProvider.data.count, testSubbreeds.count)
    }
    
    func testUpdateDataLabelVisibility() {
        // when
        presenter.updateDataLabelVisibility(hasSubbreeds: true)
        // then
        XCTAssertEqual(viewController.isNoDataLabelHidden, true)
        
        // when
        presenter.updateDataLabelVisibility(hasSubbreeds: false)
        // then
        XCTAssertEqual(viewController.isNoDataLabelHidden, false)
    }
}

class ImageLoaderMock: ImageLoader {
    var loadImageFromDidCalled = 0
    var testCompletionResult: UIImage?
    
    func loadImageFrom(urlString: String, completion: @escaping (UIImage?) -> Void) {
        loadImageFromDidCalled += 1
        completion(testCompletionResult)
    }
}

class DogGalleryServerServiceMock: DogGalleryServerProtocol {
    var getDogRandomImageUrlDidCalled = 0
    var testCompletionResult: String?
    var testCompletionError: Error?
    
    func getDogRandomImageUrl(breed: String, completion: @escaping (String?, Error?) -> Void) {
        getDogRandomImageUrlDidCalled += 1
        completion(testCompletionResult, testCompletionError)
    }
}

class DogGalleryStorageServiceMock: DogGalleryStorageProtocol {
    var favouriteDogBreedStub: String?
    
    func getFavouriteDogBreed() -> String? {
        return favouriteDogBreedStub
    }
    
    func setFavouriteDogBreed(_ breed: String?) {
        favouriteDogBreedStub = breed
    }
}

class DogGalleryViewControllerMock: DogGalleryViewInterface {
    var isHudDisplayed = false
    var isDogImageSet = false
    var isRightBarButtonHighlighted = false
    var isNoDataLabelHidden = false
    
    func setDogImage(_ image: UIImage) {
        isDogImageSet = true
    }
    
    func setNavigationTitle(_ title: String) {
        
    }
    
    func showHUD(animated: Bool) {
        isHudDisplayed = true
    }
    
    func hideHUD(animated: Bool) {
        isHudDisplayed = false
    }
    
    func setRightBarButtonItemHighlightState(_ isOn: Bool, animated: Bool) {
        isRightBarButtonHighlighted = isOn
    }
    
    func setCollectionViewProvider(_ provider: CollectionViewProvider) {
        
    }
    
    func reloadCollectionView() {
        
    }
    
    func showNoDataLabel() {
        isNoDataLabelHidden = false
    }
    
    func hideNoDataLabel() {
        isNoDataLabelHidden = true
    }
}


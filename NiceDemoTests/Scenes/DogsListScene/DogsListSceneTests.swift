//
//  DogsListSceneTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 1/20/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: DogsListViewController, DogsListPresenter
///

class DogsListSceneTests: XCTestCase {
    
    var viewController: DogsListViewController!
    var presenter: DogsListPresenter!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = DogsListViewController()
        presenter = DogsListPresenter(view: viewController)
        viewController.setPresenter(presenter)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        presenter = nil
    }
    
    func testShowOfFavouriteButton() {
        // when
        presenter.updateFavouriteButtonVisibility(hasFavouriteDog: true)
        // then
        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem, "Right barButtonItem must exist")
    }
    
    func testHideOfFavouriteButton() {
        // when
        presenter.updateFavouriteButtonVisibility(hasFavouriteDog: true)
        presenter.updateFavouriteButtonVisibility(hasFavouriteDog: false)
        // then
        XCTAssertNil(viewController.navigationItem.rightBarButtonItem, "Right barButtonItem must not exist")
    }
    
    func testLoadingViewState() {
        // when
        presenter.updateViewBasedOn(state: .loading)
        let setTableViewDataSource = viewController.customView.tableView.dataSource as? LoadingTableViewProvider
        let setTableViewDelegate = viewController.customView.tableView.delegate as? LoadingTableViewProvider
        // then
        XCTAssertEqual(setTableViewDataSource, presenter.loadingTableViewProvider)
        XCTAssertEqual(setTableViewDelegate, presenter.loadingTableViewProvider)
    }
    
    func testResultViewState() {
        // when
        XCTAssertTrue(presenter.fetchedData.isEmpty, "`fetchedData` array must be empty before result state occured.")
        let data = [Dog(breed: "Dog1", subbreeds: []), Dog(breed: "Dog2", subbreeds: [])]
        presenter.updateViewBasedOn(state: .result(data))
        let setTableViewDataSource = viewController.customView.tableView.dataSource as? DogsListTableViewProvider
        let setTableViewDelegate = viewController.customView.tableView.delegate as? DogsListTableViewProvider
        // then
        XCTAssertEqual(setTableViewDataSource, presenter.contentTableViewProvider)
        XCTAssertEqual(setTableViewDelegate, presenter.contentTableViewProvider)
        XCTAssertTrue(!presenter.fetchedData.isEmpty, "`fetchedData` array must be not empty when existing data was fetched from server.")
    }
    
    func testErrorViewState() {
        //when
        let testRect = CGRect(x: 0, y: 0, width: 400, height: 600)
        let window = UIWindow(frame: testRect)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        XCTAssertNil(viewController.presentedViewController)
        presenter.updateViewBasedOn(state: .error(message: ""))
        //then
        XCTAssertTrue(viewController.presentedViewController is UIAlertController)
    }
}

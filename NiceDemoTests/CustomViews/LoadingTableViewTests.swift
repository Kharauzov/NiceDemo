//
//  LoadingTableViewTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 1/20/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: LoadingTableViewProvider
///

class LoadingTableViewTests: XCTestCase {

    var tableView: UITableView!
    var tableViewProvider: LoadingTableViewProvider!
    let definedNumberOfSections = 2
    let definedNumberOfRowsPerSection = 9
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        tableView = UITableView()
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.reuseIdentifier)
        let configuration = LoadingTableViewProvider.Configuration(numberOfSections: definedNumberOfSections, numberOfRowsInSection: definedNumberOfRowsPerSection)
        tableViewProvider = LoadingTableViewProvider(configuration: configuration)
        tableView.dataSource = tableViewProvider
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        tableViewProvider = nil
        tableView = nil
    }

    func testTableViewDataSource() {
        // when
        XCTAssertNotNil(tableView.dataSource)
        
        // then
        XCTAssertEqual(tableView.dataSource?.numberOfSections?(in: tableView), definedNumberOfSections, "Number of sections must be equal to `definedNumberOfSections`.")
        XCTAssertEqual(tableView.dataSource?.tableView(tableView, numberOfRowsInSection: 0), definedNumberOfRowsPerSection, "Number of rows must be equal to `definedNumberOfRowsPerSection`.")
    }
    
    func testTableViewCell() {
        // when
        let cell = tableView.dataSource?.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? LoadingTableViewCell
        
        // then
        XCTAssertNotNil(cell, "Must exists.")
    }
}

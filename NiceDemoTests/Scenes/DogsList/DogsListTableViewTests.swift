//
//  DogsListTableViewTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 3/24/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: DogsListTableView Components: DogsListTableViewProvider, DogsListTableViewProviderDelegate,
///      DogBreedTableViewCell
///

class DogsListTableViewTests: XCTestCase {
    
    var tableView: UITableView!
    var tableViewProvider: DogsListTableViewProvider!
    var selectedIndex: Int?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        tableView = UITableView()
        tableView.register(DogBreedTableViewCell.self, forCellReuseIdentifier: DogBreedTableViewCell.reuseIdentifier)
        tableViewProvider = DogsListTableViewProvider()
        tableViewProvider.didSelectItem = { [unowned self] (_ atIndex: Int) in
            self.selectedIndex = atIndex
        }
        let data = [DogBreedViewModel(title: "Akita", subtitle: "Westhighland, Yorkshire"), DogBreedViewModel(title: "Terrier", subtitle: "")]
        tableViewProvider.data = data
        tableView.dataSource = tableViewProvider
        tableView.delegate = tableViewProvider
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        tableViewProvider = nil
        tableView = nil
        selectedIndex = nil
        super.tearDown()
    }
    
    func testTableViewDataSource() {
        // then
        XCTAssertEqual(tableViewProvider.tableView(tableView, numberOfRowsInSection: 0), 2, "Number of rows must be equal number of items in `data` property.")
    }
    
    func testTableViewCell() {
        // when
        let cell = tableViewProvider.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? DogBreedTableViewCell
        let title = cell?.getTitle()
        let subtitle = cell?.getSubtitle()
        
        // then
        XCTAssertNotNil(cell, "Must exists.")
        XCTAssertEqual(title, "Akita", "Dismatch.")
        XCTAssertEqual(subtitle, "Westhighland, Yorkshire", "Dismatch.")
    }
    
    func testTableViewDelegate() {
        // when
        tableViewProvider.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        // then
        XCTAssertEqual(selectedIndex, 0, "Index must be equal to 0.")
    }
    
}

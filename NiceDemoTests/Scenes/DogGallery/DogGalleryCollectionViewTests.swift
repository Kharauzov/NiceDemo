//
//  DogGalleryCollectionViewTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 18.04.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: DogGalleryCollectionView
///

class DogGalleryCollectionViewTests: XCTestCase {

    var collectionViewProvider: DogBreedsCollectionViewProvider!
    var collectionView: UICollectionView!
    let data = ["Test1", "Test2", "Test3"]
    
    override func setUp() {
        collectionViewProvider = DogBreedsCollectionViewProvider()
        collectionViewProvider.data = data
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(DogBreedCollectionViewCell.self, forCellWithReuseIdentifier: DogBreedCollectionViewCell.reuseIdentifier)
        collectionView.delegate = collectionViewProvider
        collectionView.dataSource = collectionViewProvider
    }
    
    override func tearDown() {
        collectionView = nil
        collectionViewProvider = nil
    }
    
    func testNumberOfItems() {
        // then
        XCTAssertEqual(collectionViewProvider.collectionView(collectionView, numberOfItemsInSection: 0), data.count)
    }
    
    func testCellForItem() {
        // given
        guard let cell = collectionViewProvider.collectionView(collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as? DogBreedCollectionViewCell else {
            XCTFail("Cell must exist")
            return
        }
        // then
        XCTAssertEqual(cell.titleLabel.text, data[0])
    }
}

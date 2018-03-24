//
//  ReusableViewTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 3/24/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo


class MockView: ReusableView {
}

///
/// SUT: ReusableView
///

class ReusableViewTests: XCTestCase {    
    func testReuseIdentifier() {
      XCTAssertEqual(MockView.reuseIdentifier, "MockView", "ReuseIndentifier must match class name.")
    }
}

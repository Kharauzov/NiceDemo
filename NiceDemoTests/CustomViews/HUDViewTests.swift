//
//  HUDViewTests.swift
//  NiceDemoTests
//
//  Created by Serhii Kharauzov on 3/24/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import XCTest
@testable import NiceDemo

///
/// SUT: HUDView
///

class HUDViewTests: XCTestCase {
    
    var hud: HUDView!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        hud = HUDView(frame: CGRect.zero, backgroundColor: nil, tintColor: nil)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        hud = nil
        super.tearDown()
    }
    
    func testHUDAnimating() {
        XCTAssertFalse(hud.isAnimating(), "HUD must be idle at this moment.")
        // when
        hud.startAnimating()
        // then
        XCTAssertTrue(hud.isAnimating(), "HUD must be active at this moment")
        // when
        hud.stopAnimating()
        // then
        XCTAssertFalse(hud.isAnimating(), "HUD must be idle at this moment.")
    }
    
    func testHUDViewAsSubview() {
        let view = UIView(frame: .zero)
        // when
        view.showHUD(animated: true)
        // then
        var oldHUD = HUDView.hudIn(view: view)
        XCTAssertNotNil(oldHUD, "HUD must be subview of view.")
        // when
        view.hideHUD(animated: false)
        // then
        oldHUD = HUDView.hudIn(view: view)
        XCTAssertNil(oldHUD, "HUD must be removed from superview and be nil.")
    }
}

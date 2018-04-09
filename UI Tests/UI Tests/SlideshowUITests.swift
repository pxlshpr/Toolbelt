//
//  UI_TestsUITests.swift
//  UI TestsUITests
//
//  Created by pxlshpr on 10/4/18.
//  Copyright © 2018 pxlshpr. All rights reserved.
//

import XCTest

class UI_TestsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      //TODO:
      //- take snapshot of slideshow and confirm that its the first photo using Snapshot
      //- then pan the slideshow and confirm that the next photo is what's expecetd too
      //TODO: what about indicators?
    }
    
}

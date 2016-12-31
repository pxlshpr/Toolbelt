//
//  UIColorTests.swift
//  Toolbelt
//
//  Created by Ahmed Khalaf on 30/12/16.
//  Copyright © 2016 Ahmed Khalaf. All rights reserved.
//

import XCTest
@testable import Toolbelt

class UIColorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitWithHex() {
        
        let threeCharacters = UIColor(hexString: "#2DC")
        XCTAssertEqual(34.0, CIColor(color: threeCharacters).red * 255.0)
        XCTAssertEqual(221.0, CIColor(color: threeCharacters).green * 255.0)
        XCTAssertEqual(204.0, CIColor(color: threeCharacters).blue * 255.0)
        XCTAssertEqual(1.0, CIColor(color: threeCharacters).alpha)
        
        let sixCharacters = UIColor(hexString: "#35ECD5")
        let withoutHashSign = UIColor(hexString: "35ECD5")
        for color in [sixCharacters, withoutHashSign] {
            XCTAssertEqual(53.0, CIColor(color: color).red * 255.0)
            XCTAssertEqual(236.0, CIColor(color: color).green * 255.0)
            XCTAssertEqual(213.0, CIColor(color: color).blue * 255.0)
            XCTAssertEqual(1.0, CIColor(color: color).alpha)
        }
        
        let invalid1 = UIColor(hexString: "#ASMX@S)@")
        let invalid2 = UIColor(hexString: "not a hex string")
        let invalid3 = UIColor(hexString: "")
        let invalid4 = UIColor(hexString: "FF#FFFF")
        for color in [invalid1, invalid2, invalid3, invalid4] {
        //            XCTAssertEqual(color, UIColor.black)
        
            XCTAssertEqual(0.0, CIColor(color: color).red * 255.0)
            XCTAssertEqual(0.0, CIColor(color: color).green * 255.0)
            XCTAssertEqual(0.0, CIColor(color: color).blue * 255.0)
            XCTAssertEqual(1.0, CIColor(color: color).alpha)
        }
    }
}

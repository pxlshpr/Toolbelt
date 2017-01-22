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
    
    let color1 = UIColor(hexString: "#2DC")
    XCTAssertNotNil(color1, "Failed to create color from valid hex")
    XCTAssertEqual(34.0, CIColor(color: color1!).red * 255.0, "Color created from hex has invalid red component")
    XCTAssertEqual(221.0, CIColor(color: color1!).green * 255.0, "Color created from hex has invalid green component")
    XCTAssertEqual(204.0, CIColor(color: color1!).blue * 255.0, "Color created from hex has invalid blue component")
    XCTAssertEqual(1.0, CIColor(color: color1!).alpha, "Color created from hex has invalid alpha component")

    let color2 = UIColor(hexString: "#35ECD5")
    let color3 = UIColor(hexString: "35ECD5")
    for color in [color2, color3] {
      XCTAssertNotNil(color, "Failed to create color from valid hex")
      XCTAssertEqual(53.0, CIColor(color: color!).red * 255.0, "Color created from hex has invalid red component")
      XCTAssertEqual(236.0, CIColor(color: color!).green * 255.0, "Color created from hex has invalid green component")
      XCTAssertEqual(213.0, CIColor(color: color!).blue * 255.0, "Color created from hex has invalid blue component")
      XCTAssertEqual(1.0, CIColor(color: color!).alpha, "Color created from hex has invalid alpha component")
    }

    let invalid1 = UIColor(hexString: "#ASMX@S)@")
    let invalid2 = UIColor(hexString: "not a hex string")
    let invalid3 = UIColor(hexString: "")
    let invalid4 = UIColor(hexString: "FF#FFFF")
    for color in [invalid1, invalid2, invalid3, invalid4] {
      XCTAssertNil(color, "UIColor was (incorrectly) created for invalid hex")
    }
  }
}

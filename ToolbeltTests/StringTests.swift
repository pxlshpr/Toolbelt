import XCTest
@testable import Toolbelt

class ToolbeltTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIsValidHexNumber() {
        
        let valid1 = "ABF0C5"
        let valid2 = "FFF"
        let valid3 = "AF00000F000"
        
        let invalid1 = "ASMX@S"
        let invalid2 = "GGG"
        let invalid3 = "^$&@#(&@#"
        
        XCTAssertTrue(valid1.isValidHexNumber())
        XCTAssertTrue(valid2.isValidHexNumber())
        XCTAssertTrue(valid3.isValidHexNumber())

        XCTAssertFalse(invalid1.isValidHexNumber())
        XCTAssertFalse(invalid2.isValidHexNumber())
        XCTAssertFalse(invalid3.isValidHexNumber())
    }
    
}

import XCTest
@testable import Toolbelt

class ToolbeltTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIsValidHexadecimal() {
        
        let valid1 = "ABF0C5"
        let valid2 = "FFF"
        let valid3 = "AF00000F000"
        
        let invalid1 = "ASMX@S"
        let invalid2 = "GGG"
        let invalid3 = "^$&@#(&@#"
        
        XCTAssertTrue(valid1.isValidHexadecimal)
        XCTAssertTrue(valid2.isValidHexadecimal)
        XCTAssertTrue(valid3.isValidHexadecimal)

        XCTAssertFalse(invalid1.isValidHexadecimal)
        XCTAssertFalse(invalid2.isValidHexadecimal)
        XCTAssertFalse(invalid3.isValidHexadecimal)
    }
    
}

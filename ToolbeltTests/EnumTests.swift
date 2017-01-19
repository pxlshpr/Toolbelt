import XCTest
@testable import Toolbelt

class EnumTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIterateEnum() {
        
        enum Enum {
            case Case1, Case2, Case3, Case4, Case5
        }
        
        var numberOfCases = 0
        for _ in iterateEnum(Enum.self) {
            numberOfCases += 1
        }
        
        XCTAssertTrue(numberOfCases == 5)
    }
    
}

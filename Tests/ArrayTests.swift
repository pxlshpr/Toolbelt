import XCTest
@testable import Toolbelt

class ArrayTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testAllEqual() {
    XCTAssertTrue([1, 1, 1].containsDuplicates)
    XCTAssertFalse([1, 2, 1].containsDuplicates)
    //TODO: make this a property, in the Swift 3 spirit
    //TODO: write more obscure test cases to try and break this
  }
}


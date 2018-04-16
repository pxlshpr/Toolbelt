import XCTest
@testable import Toolbelt

class EnumTests: XCTestCase {
  
  enum Enum {
    case Case1, Case2, Case3, Case4, Case5
  }
  
  enum EnumSingleCase {
    case Case1
  }
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testNumberOfCases() {
    let message = "Failed to get correct number of enum cases"
    XCTAssertEqual(numberOfCases(Enum.self), 5, message)
    XCTAssertEqual(numberOfCases(EnumSingleCase.self), 1, message)
  }
  
  func testEnumIterator() {
    var caseMatches = [false, false, false, false, false]
    for theCase in enumIterator(Enum.self) {
      if theCase == .Case1 { caseMatches[0] = true }
      if theCase == .Case2 { caseMatches[1] = true }
      if theCase == .Case3 { caseMatches[2] = true }
      if theCase == .Case4 { caseMatches[3] = true }
      if theCase == .Case5 { caseMatches[4] = true }
    }
    XCTAssertEqual(caseMatches, [true, true, true, true, true], "Failed to iterate through all cases")
  }
}

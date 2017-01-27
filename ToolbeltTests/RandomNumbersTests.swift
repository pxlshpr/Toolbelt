import XCTest
@testable import Toolbelt

class RandomNumbersTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  //TODO: move to Toolbelt (under test helpers)
  func assertThat(_ firstObject: Any, matchesType secondObject: Any, withmessage message: String?) {
      let typeOfRandom = type(of: random)
      let typeOfNumber = type(of: number)
      let typesAreEqual = typeOfRandom == typeOfNumber
      XCTAssertTrue(typesAreEqual, message ?? "Types don't match as expected")  
  }
  
  func testRandomNumbersFrom0() {
    
    let numbers = [0, 1, 5, 100, 5000, UInt(0), UInt(1), UInt(5), UInt(100), UInt(5000) ]
    
    for number in numbers {
      let random = randomIntegerBetween0(and: number)
      XCTAssertGreaterThanOrEqual(random, 0, "Random number generated was less than 0")
      XCTAssertGreaterThanOrEqual(number, random, "Random number generated was greater than the upper limit")
      assertThat(number, matchesTypeOf: random, message: "Returned random number wasn't of the same type as the input upper limit")
            
      //TODO: see if this existsa lready before attempting
      //TODO: think about handling negative numbers with both functions
      //TODO: try to extend the same functions to handle doubles and floats as well, if possible!, see if there is a protocl higher up than Integer that could be used for the generic
    }
  }
  
  func testRandomNumberInARange() {
    let ranges = [(0, 10), (100, 1000), (9, 10), (0, 0)]
    for range in ranges {
      for _ in 0..<5 {
        let random = randomIntegerInclusively(between: range.0, and: range.1)
        XCTAssertLessThanOrEqual(range.0, random, "Random number was less than the lower limit")
        XCTAssertGreaterThanOrEqual(range.1, random, "Random number was greater than the upper limit")
      }
    }
  }
  
}

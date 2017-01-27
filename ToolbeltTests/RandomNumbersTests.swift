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
  func assertThat(_ firstObject: Any, matchesTypeOf secondObject: Any, message: String?) {
      let typeOfRandom = type(of: firstObject)
      let typeOfNumber = type(of: secondObject)
      let typesAreEqual = typeOfRandom == typeOfNumber
      XCTAssertTrue(typesAreEqual, message ?? "Types don't match as expected")  
  }
  
  func testRandomNumbersFrom0() {
    
    let limitsInt = [-5000000, -5000, -100, -5, -2, -1, 0, 1, 2, 5, 100, 5000]
    var limitsInt8: [Int8] = []
    
    for  limit in limitsInt {
      //TODO: handle negatives with unsigned types else overflows!
      //TODO: can we chain these?
      var int8 = min(limit, Int8.max)
      int8 = max(Int8.min, limit)
      limitsInt8.append(Int8(int8)
      )
    }
    
    //TODO: find out how to 'swift define array with generic'.
    // then add all randoms here as we generate them (and make sure we have a lot more samples to test on).
    // then assert (in the end) that all the generated randoms weren't:
    // 1. the same (but only depending on the range. So a range of (0, 0) if applicable might be an exception)
    // 2. too similar to each other (ie. too many repeats – but that depends on the range doens't it? don't divulge in this too much. Maybe just trust that even a slight randomness (ie. different number) is random enough
    var randoms: Any = []
    
    for limit in limits {
      let random = randomIntegerBetween0(and: limit)
      XCTAssertGreaterThanOrEqual(random, 0, "Random number generated was less than 0")
      //TODO: need to change this if we're handling negative numbers
      XCTAssertLessThanOrEqual(random, limit, "Random number generated was greater than the limit")
      assertThat(random, matchesTypeOf: limit, message: "Returned random number wasn't of the same type as the input upper limit")

      //TODO: we need a failing test for when we get a 'random' number that isn't random. ie. it's the same everytime. should we test for how variant/random they actually are too? or is that too abstract?
      
      //TODO: think about handling negative numbers with both functions
      //TODO: try to refactor to handle doubles and floats
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

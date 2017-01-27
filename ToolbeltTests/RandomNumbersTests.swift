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
      XCTAssertTrue(typesAreEqual, message ?? "Types do not match as expected")  
  }
  
  func testRandomNumbersFrom0() {
    
    let limitsInt = [Int.min, -5000000000000, -5000000, -5000, -100, -5, -2, -1, 0, 1, 2, 5, 100, 5000, 5000000, 5000000000000, Int.max]
    let limitsUInt: [UInt] = [0, 1, 2, 5, 100, 5000, 5000000, 5000000000000, UInt.max]

    var limitsInt8: [Int8] = []
    var limitsInt16: [Int16] = []
    var limitsInt32: [Int32] = []
    var limitsInt64: [Int64] = []

    var limitsUInt8: [UInt8] = []
    var limitsUInt16: [UInt16] = []
    var limitsUInt32: [UInt32] = []
    var limitsUInt64: [UInt64] = []

    for limit in limitsInt {
      limitsInt8.append(Int8(max(Int(Int8.min), min(limit, Int(Int8.max)))))
      limitsInt16.append(Int16(max(Int(Int16.min), min(limit, Int(Int16.max)))))
      limitsInt32.append(Int32(max(Int(Int32.min), min(limit, Int(Int32.max)))))
      limitsInt64.append(Int64(max(Int(Int64.min), min(limit, Int(Int64.max)))))
    }

    for limit in limitsUInt {
      limitsUInt8.append(UInt8(max(UInt(UInt8.min), min(limit, UInt(UInt8.max)))))
      limitsUInt16.append(UInt16(max(UInt(UInt16.min), min(limit, UInt(UInt16.max)))))
      limitsUInt32.append(UInt32(max(UInt(UInt32.min), min(limit, UInt(UInt32.max)))))
      limitsUInt64.append(UInt64(max(UInt(UInt64.min), min(limit, UInt(UInt64.max)))))
    }

    var limits: [Any] = []
    let arrays = [limitsInt, limitsInt8, limitsInt16, limitsInt32, limitsInt64, limitsUInt, limitsUInt8, limitsUInt16, limitsUInt32, limitsUInt64] as [[Any]]
    for array in arrays {
      limits.append(contentsOf: array)
    }
    
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

import XCTest
@testable import Toolbelt

class RandomNumbersTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  lazy var testValues_UInts: [UInt] = {
    return [0, 1, 2, 1000, Int.max, UInt.max]
  }()
  
  lazy var testValues_Ints: [Int] = {
    return [Int.min, -1000, -2, -1, 0, 1, 2, 1000, Int.max]
  }()

  lazy var testValues_Doubles: [Double] = {
    return [-DBL_MAX, -FLT_MAX, -2.5, -1.5, -1, -0.5, -0.1, -DBL_MIN, -FLT_MIN, 0, FLT_MIN, DBL_MIN, 0.1, 0.5, 1, 1.5, 2.5, FLT_MAX, DBL_MAX]
  }()

  lazy var testValues_Floats: [Float] = {
    return [-FLT_MAX, -2.5, -1.5, -1, -0.5, -0.1, -DBL_MIN, -FLT_MIN, 0, FLT_MIN, DBL_MIN, 0.1, 0.5, 1, 1.5, 2.5, FLT_MAX]
  }()

  //TODO modularize the code
  func testUIntRandom_AllCases_ReturnsARandomWithinRange() {
    for a in testValues_UInts {
      for b in testValues_UInts {
        //TODO only check for equality
        if a != b {
          
          let min = a > b ? b : a
          let max = a > b ? a : b
          var randoms: [UInt] = []
          (0..<100).forEach { _ in
            let random = UInt.random(between: min, and: max)
            XCTAssertGreaterThanOrEqual(random, min, "Random number wasn't greater than or equal to the minimum")
            XCTAssertLessThanOrEqual(random, max, "Random number wasn't less or equal to the maximum")
            randoms.append(random)
          }
          XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
        } else {
          let random = UInt.random(between: a, and: b)
          XCTAssertEqual(random, a, "Random number generated was out of the range")
          XCTAssertEqual(random, b, "Random number generated was out of the range")
        }
      }
    }
  }
  
  func testIntRandom_AllCases_ReturnsARandomWithinRange() {
    for a in testValues_Ints {
      for b in testValues_Ints {
        //TODO only check for equality
        if a != b {
          
          let min = a > b ? b : a
          let max = a > b ? a : b
          var randoms: [Int] = []
          (0..<100).forEach { _ in
            let random = Int.random(between: min, and: max)
            XCTAssertGreaterThanOrEqual(random, min, "Random number wasn't greater than or equal to the minimum")
            XCTAssertLessThanOrEqual(random, max, "Random number wasn't less or equal to the maximum")
            randoms.append(random)
          }
          XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
        } else {
          let random = Int.random(between: a, and: b)
          XCTAssertEqual(random, a, "Random number generated was out of the range")
          XCTAssertEqual(random, b, "Random number generated was out of the range")
        }
      }
    }
  }
  
  func testDoubleRandom_AllCases_ReturnsARandomWithinRange() {
    for a in testValues_Doubles {
      for b in testValues_Doubles {
        //TODO only check for equality
        if a != b {
          
          let min = a > b ? b : a
          let max = a > b ? a : b
          var randoms: [Double] = []
          (0..<100).forEach { _ in
            let random = Double.random(between: min, and: max)
            XCTAssertGreaterThanOrEqual(random, min, "Random number wasn't greater than or equal to the minimum")
            XCTAssertLessThanOrEqual(random, max, "Random number wasn't less or equal to the maximum")
            randoms.append(random)
          }
          XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
        } else {
          let random = Double.random(between: a, and: b)
          XCTAssertEqual(random, a, "Random number generated was out of the range")
          XCTAssertEqual(random, b, "Random number generated was out of the range")
        }
      }
    }
  }

  func testFloatRandom_AllCases_ReturnsARandomWithinRange() {
    for a in testValues_Floats {
      for b in testValues_Floats {
        //TODO only check for equality
        print("testing random between \(a) and \(b)...")
        if a != b {
          let min = a > b ? b : a
          let max = a > b ? a : b
          var randoms: [Float] = []
          (0..<100).forEach { _ in
            let random = Float.random(between: min, and: max)
            XCTAssertGreaterThanOrEqual(random, min, "Random number wasn't greater than or equal to the minimum")
            XCTAssertLessThanOrEqual(random, max, "Random number wasn't less or equal to the maximum")
            randoms.append(random)
          }
          XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
        } else {
          let random = Float.random(between: a, and: b)
          XCTAssertEqual(random, a, "Random number generated was out of the range")
          XCTAssertEqual(random, b, "Random number generated was out of the range")
        }
      }
    }
  }

  func testUIntRangeRandom_ValidCases_ReturnsARandomInt() {
    for a in testValues_UInts {
      for b in testValues_UInts {
        if a > UInt(Int.max) {
          // since the retun value is Int – this helper doesn't work as expected when the lower bound is greater than Int.max
          continue
        }
        if a < b {
          let range = (a...b)
          
          let min = a > b ? b : a
          let max = a > b ? a : b
          var randoms: [Int] = []
          (0..<100).forEach { _ in
            let random = range.random
            XCTAssertGreaterThanOrEqual(UInt(random), min, "Random number wasn't greater than or equal to the minimum")
            XCTAssertLessThanOrEqual(UInt(random), max, "Random number wasn't less or equal to the maximum")
            randoms.append(random)
          }
          XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
        } else if a == b {
          
          let random = (a...b).random
          XCTAssertEqual(UInt(random), a, "Random number generated was out of the range")
          XCTAssertEqual(UInt(random), b, "Random number generated was out of the range")
        } else {
          // Can't form Range with upperBound < lowerBound
        }
      }
    }
  }
  func testClosedUIntRangeRandom_ValidCases_ReturnsARandomInt() { }
  func testIntRangeRandom_ValidCases_ReturnsARandomInt() { }
  func testClosedIntRangeRandom_ValidCases_ReturnsARandomInt() { }
  func testDoubleRangeRandom_ValidCases_ReturnsARandomInt() { }
  func testClosedDoubleRangeRandom_ValidCases_ReturnsARandomInt() { }
  func testFloatRangeRandom_ValidCases_ReturnsARandomInt() { }
  func testClosedFloatRangeRandom_ValidCases_ReturnsARandomInt() { }

  func testUIntRangeRandom_InvalidCases_() { }
  func testClosedUIntRangeRandom_InvalidCases_() { }
  func testIntRangeRandom_InvalidCases_() { }
  func testClosedIntRangeRandom_InvalidCases_() { }
  func testDoubleRangeRandom_InvalidCases_() { }
  func testClosedDoubleRangeRandom_InvalidCases_() { }

  func testUIntRangeRandom_RedundantCases_() { }
  func testClosedUIntRangeRandom_RedundantCases_() { }
  func testIntRangeRandom_RedundantCases_() { }
  func testClosedIntRangeRandom_RedundantCases_() { }
  func testDoubleRangeRandom_RedundantCases_() { }
  func testClosedDoubleRangeRandom_RedundantCases_() { }
}

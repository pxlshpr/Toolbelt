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
    return [0, 1, 2, 1000, UInt.max]
  }()
  
  lazy var testValues_Ints: [Int] = {
    return [Int.min, -1000, -2, -1, 0, 1, 2, 1000, Int.max]
  }()

  lazy var testValues_Doubles: [Double] = {
    return [-DBL_MAX ,-2.5 ,-1.5 ,-1 ,-0.5 ,-0.1 ,-DBL_MIN ,0 ,DBL_MIN ,0.1 ,0.5 ,1 ,1.5 ,2.5, DBL_MAX]
  }()

  func testUIntRandom_ValidCases_ReturnsARandomUInt() {
    for min in testValues_UInts {
      for max in testValues_UInts {
        if min < max {
          var randoms: [UInt] = []
          (0..<100).forEach { _ in
            let random = UInt.random(minValue: min, maxValue: max)
            XCTAssertGreaterThanOrEqual(random, min, "Random number wasn't greater than or equal to the minimum")
            XCTAssertLessThanOrEqual(random, max, "Random number wasn't less or equal to the maximum")
            randoms.append(random)
          }
          XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
        }
      }
    }
  }
  
  func testIntRandom_ValidCases_ReturnsARandomUInt() {
    for min in testValues_Ints {
      for max in testValues_Ints {
        if min < max {
          var randoms: [Int] = []
          (0..<100).forEach { _ in
            let random = Int.random(minValue: min, maxValue: max)
            XCTAssertGreaterThanOrEqual(random, min, "Random number wasn't greater than or equal to the minimum")
            XCTAssertLessThanOrEqual(random, max, "Random number wasn't less or equal to the maximum")
            randoms.append(random)
          }
          XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
        }
      }
    }
  }
  
  func testDoubleRandom_ValidCases_ReturnsARandomUInt() {
    for min in testValues_Doubles {
      for max in testValues_Doubles {
        if min < max {
          var randoms: [Double] = []
          (0..<100).forEach { _ in
            let random = Double.random(minValue: min, maxValue: max)
            XCTAssertGreaterThanOrEqual(random, min, "Random number wasn't greater than or equal to the minimum")
            XCTAssertLessThanOrEqual(random, max, "Random number wasn't less or equal to the maximum")
            randoms.append(random)
          }
          XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
        }
      }
    }
  }
  
  func testUIntRandom_InvalidCases_() { }
  func testIntRandom_InvalidCases_() { }
  func testDoubleRandom_InvalidCases_() { }

  func testUIntRandom_RedundantCases_() { }
  func testIntRandom_RedundantCases_() { }
  func testDoubleRandom_RedundantCases_() { }

  func testUIntRangeRandom_ValidCases_ReturnsARandomInt() { }
  func testClosedUIntRangeRandom_ValidCases_ReturnsARandomInt() { }
  func testIntRangeRandom_ValidCases_ReturnsARandomInt() { }
  func testClosedIntRangeRandom_ValidCases_ReturnsARandomInt() { }
  func testDoubleRangeRandom_ValidCases_ReturnsARandomInt() { }
  func testClosedDoubleRangeRandom_ValidCases_ReturnsARandomInt() { }

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

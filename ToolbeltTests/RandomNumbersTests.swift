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
    return [0, 1, 2, 1000, UInt(Int.max), UInt.max]
  }()
  
  lazy var testValues_Ints: [Int] = {
    return [Int.min, -1000, -2, -1, 0, 1, 2, 1000, Int.max]
  }()

  lazy var testValues_Doubles: [Double] = {
    return [-DBL_MAX, Double(-FLT_MAX), -2.5, -1.5, -1, -0.5, -0.1, -DBL_MIN, -Double(FLT_MIN), 0, Double(FLT_MIN), DBL_MIN, 0.1, 0.5, 1, 1.5, 2.5, Double(FLT_MAX), DBL_MAX]
  }()

  lazy var testValues_Floats: [Float] = {
    return [-FLT_MAX, -2.5, -1.5, -1, -0.5, -0.1, Float(-DBL_MIN), -FLT_MIN, 0, FLT_MIN, Float(DBL_MIN), 0.1, 0.5, 1, 1.5, 2.5, FLT_MAX]
  }()

  //MARK: - Class Random Functions

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

  //MARK: - Range Extensions
  
  func testClosedUIntRangeRandom_ValidCases_ReturnsARandomInt() {
    
    for min in testValues_UInts {
      for max in testValues_UInts {
        if min < max {
          let range = (min...max)
          
          var randoms: [UInt] = []
          (0..<100).forEach { _ in
            let random = range.random
            XCTAssertGreaterThanOrEqual(random, min, "Random number wasn't greater than or equal to the minimum")
            XCTAssertLessThanOrEqual(random, max, "Random number wasn't less or equal to the maximum")
            randoms.append(random)
          }
          XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
        } else if min == max {
          
          let random = (min...max).random
          XCTAssertEqual(random, min, "Random number generated was out of the (empty) range")
        } else {
          // Can't form Range with upperBound < lowerBound
        }
      }
    }
  }
  
  func testClosedIntRangeRandom_ValidCases_ReturnsARandomInt() {
    
    for min in testValues_Ints {
      for max in testValues_Ints {
        if min < max {
          let range = (min...max)
          
          var randoms: [Int] = []
          (0..<100).forEach { _ in
            let random = range.random
            XCTAssertGreaterThanOrEqual(random, min, "Random number wasn't greater than or equal to the minimum")
            XCTAssertLessThanOrEqual(random, max, "Random number wasn't less or equal to the maximum")
            randoms.append(random)
          }
          XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
        } else if min == max {
          
          let random = (min...max).random
          XCTAssertEqual(random, min, "Random number generated was out of the (empty) range")
        } else {
          // Range's cannot be created with lowerBound > upperBound – so we skip this combination
        }
      }
    }
  }

  func testOpenUIntRangeRandom_ValidCases_ReturnsARandomInt() {
    
    for min in testValues_UInts {
      for max in testValues_UInts {
        if min < max {
          if min < max - 1 {
            let range = (min..<max)
            
            var randoms: [UInt] = []
            (0..<100).forEach { _ in
              let random = range.random
              XCTAssertGreaterThanOrEqual(random, min, "Random number wasn't greater than or equal to the minimum")
              XCTAssertLessThan(random, max, "Random number wasn't less or equal to the maximum")
              randoms.append(random)
            }
            XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
          } else {
            
            // these test the cases such as 0..<1 which is technically 0...0
            let random = (min..<max).random
            XCTAssertGreaterThanOrEqual(random, min, "Random number generated was outside the provided range")
            XCTAssertLessThanOrEqual(random, max, "Random number generated was outside the provided range")
          }
        } else if min == max {
          
          // these tests are for the wierd closed range possibilities (0..<0 et al.)
          let random = (min..<max).random
          XCTAssertGreaterThanOrEqual(random, min, "Random number generated was outside the provided range")
        } else {
          // Range's cannot be created with lowerBound > upperBound – so we skip this combination
        }
      }
    }
  }
  
  func testOpenIntRangeRandom_ValidCases_ReturnsARandomInt() {
    for min in testValues_Ints {
      for max in testValues_Ints {
        if min < max {
          if min < max - 1 {
            let range = (min..<max)
            
            var randoms: [Int] = []
            (0..<100).forEach { _ in
              let random = range.random
              XCTAssertGreaterThanOrEqual(random, min, "Random number wasn't greater than or equal to the minimum")
              XCTAssertLessThan(random, max, "Random number wasn't less or equal to the maximum")
              randoms.append(random)
            }
            XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
          } else {
            
            // these test the cases such as 0..<1 which is technically 0...0
            let random = (min..<max).random
            XCTAssertGreaterThanOrEqual(random, min, "Random number generated was outside the provided range")
            XCTAssertLessThanOrEqual(random, max, "Random number generated was outside the provided range")
          }
        } else if min == max {
          
          // these tests are for the wierd closed range possibilities (0..<0 et al.)
          let random = (min..<max).random
          XCTAssertGreaterThanOrEqual(random, min, "Random number generated was outside the provided range")
        } else {
          // Range's cannot be created with lowerBound > upperBound – so we skip this combination
        }
      }
    }
  }

  func testClosedDoubleRangeRandom_ValidCases_ReturnsARandomInt() {
    for min in testValues_Doubles {
      for max in testValues_Doubles {
        if min < max {
          let range = (min...max)
          
          var randoms: [Double] = []
          (0..<100).forEach { _ in
            let random = range.random
            XCTAssertGreaterThanOrEqual(random, min, "Random number wasn't greater than or equal to the minimum")
            XCTAssertLessThanOrEqual(random, max, "Random number wasn't less or equal to the maximum")
            randoms.append(random)
          }
          XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
        } else if min == max {
          
          let random = (min...max).random
          XCTAssertEqual(random, min, "Random number generated was out of the (empty) range")
        } else {
          // Range's cannot be created with lowerBound > upperBound – so we skip this combination
        }
      }
    }
  }
  
  func testClosedFloatRangeRandom_ValidCases_ReturnsARandomInt() {
    for min in testValues_Floats {
      for max in testValues_Floats {
        if min < max {
          let range = (min...max)
          
          var randoms: [Float] = []
          (0..<100).forEach { _ in
            let random = range.random
            XCTAssertGreaterThanOrEqual(random, min, "Random number wasn't greater than or equal to the minimum")
            XCTAssertLessThanOrEqual(random, max, "Random number wasn't less or equal to the maximum")
            randoms.append(random)
          }
          XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
        } else if min == max {
          let random = (min...max).random
          XCTAssertEqual(random, min, "Random number generated was out of the (empty) range")
        } else {
          // Range's cannot be created with lowerBound > upperBound – so we skip this combination
        }
      }
    }
  }
  
  func testOpenDoubleRangeRandom_ValidCases_ReturnsARandomInt() {
    for min in testValues_Doubles {
      for max in testValues_Doubles {
        if max > min + DBL_MIN  {
          let range = (min..<max)
          
          var randoms: [Double] = []
          (0..<100).forEach { _ in
            let random = range.random
            XCTAssertGreaterThanOrEqual(random, min, "Random number wasn't greater than or equal to the minimum")
            XCTAssertLessThan(random, max, "Random number wasn't less or equal to the maximum")
            randoms.append(random)
          }
          XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
        } else if min == max {
          
          let random = (min...max).random
          XCTAssertGreaterThanOrEqual(random, min, "Random number generated was out of the (empty) range")
        } else {
          // Range's cannot be created with lowerBound > upperBound – so we skip this combination
        }
      }
    }
  }
  
  func testOpenFloatRangeRandom_ValidCases_ReturnsARandomInt() {
    for min in testValues_Floats {
      for max in testValues_Floats {
        if max > min + FLT_MIN  {
          let range = (min..<max)
          
          print("testing \(range)")
          var randoms: [Float] = []
          (0..<100).forEach { _ in
            let random = range.random
            XCTAssertGreaterThanOrEqual(random, min, "Random number wasn't greater than or equal to the minimum")
            XCTAssertLessThan(random, max, "Random number wasn't less or equal to the maximum")
            randoms.append(random)
          }
          XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
        } else if min == max {
          
          let random = (min...max).random
          XCTAssertGreaterThanOrEqual(random, min, "Random number generated was out of the (empty) range")
        } else {
          // Range's cannot be created with lowerBound > upperBound – so we skip this combination
        }
      }
    }
  }

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

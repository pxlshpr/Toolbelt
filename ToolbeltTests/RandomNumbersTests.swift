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

  //TODO: rename this test
  func testUIntRandom_ValidParameters_ReturnsARandomUInt() {
    
    for min in testValues_UInts {
      for max in testValues_UInts {
        if min < max {
          
          //TODO: do this x100 or x1000 times and save the results and check if its varied (as long the range is greater than 1
          let random = UInt.random(minValue: min, maxValue: max)
          XCTAssertGreaterThanOrEqual(random, min, "Random number wasn't greater than or equal to the minimum")
          XCTAssertLessThanOrEqual(random, max, "Random number wasn't less or equal to the maximum")
        }
      }
    }
  }
  
  func testIntRandom_ValidParameters_ReturnsARandomUInt() {
    
  }
  
  func testDoubleRandom_ValidParameters_ReturnsARandomUInt() {
    
  }

  func _testRandomNumberForARange() {
    let ranges1 = [(Int.min...0), (0...10), (0...1000), (0...Int.max), (-5...0), (-1...1), (Int.min...Int.max)]
    let ranges2 = [(Int.min..<0), (0..<10), (0..<1000), (0..<Int.max), (-5..<0), (-1..<1), (Int.min..<Int.max)]
    
    //TODO: fix double ranges (not working at all) and test functions by themselves too
    //TODO: modularize code here and in Random Numbers file depending on how much is shared between Integer and Double's
    let ranges3 = [(0.5...10.5), (50000.25...50000.255)]
    let ranges4 = [(0.5..<10.5), (50000.25..<50000.255)]
    let times = 100
    
    let runTestsOnRange = { (range: Any) -> Void in
      var randoms: [Int] = []
      var randomsDouble: [Double] = []
      
      (0...times).forEach({ _ in
        
        let assertRandomNumberIsInRange = { (random: Int, lowerBound: Int, upperBound: Int) in
          XCTAssertGreaterThanOrEqual(random, lowerBound, "Random number generated was less than the lower limit")
          XCTAssertLessThan(random, upperBound, "Random number generated was greater than the upper limit")
          //TODO: randoms should be weak, right?
          
          if upperBound == lowerBound || upperBound > lowerBound + 1 {
            randoms.append(random)
          }
        }
        
        let assertDouble = { (random: Double, lowerBound: Double, upperBound: Double) in
          XCTAssertGreaterThanOrEqual(random, lowerBound, "Random number generated was less than the lower limit")
          XCTAssertLessThan(random, upperBound, "Random number generated was greater than the upper limit")
          //TODO: randoms should be weak, right?
          
          randomsDouble.append(random)
        }
        
        
        if let range = range as? CountableRange<Int> {
          assertRandomNumberIsInRange(range.random, range.lowerBound, range.upperBound)
        } else if let range = range as? CountableClosedRange<Int> {
          let upper = Swift.min(Int(range.upperBound), Int.max - 1)
          assertRandomNumberIsInRange(range.random, range.lowerBound, upper+1)
        } else if let range = range as? Range<Double> {
          assertDouble(range.random, range.lowerBound, range.upperBound)
        } else if let range = range as? ClosedRange<Double> {
          let upper = Swift.min(Double(range.upperBound), Double(Int.max - 1))
          assertDouble(range.random, range.lowerBound, upper+1)
        }
      })
      print(randoms)
      
      if !randoms.isEmpty {
        XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
      }
    }
    
    for range in ranges1 { runTestsOnRange(range) }
    for range in ranges2 { runTestsOnRange(range) }
    for range in ranges3 { runTestsOnRange(range) }
    for range in ranges4 { runTestsOnRange(range) }
    
  }
}

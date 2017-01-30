import XCTest
@testable import Toolbelt

class RandomNumbersTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  //TODO: write tests that test the Int.random UInt.random and Double.random functions separately
  //TODO: rename this test
  func testRandomNumberForARange() {
    
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

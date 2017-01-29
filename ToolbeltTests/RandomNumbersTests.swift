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

enum ToolbeltError: Error {
  case overflowError
}

class RandomNumbersTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testRandomNumberForARange() {
    
    //TODO: think about handling negatives, UInt32, Int8, Doubles, Floats
    let ranges1 = [(Int.min...0), (0...10), (0...1000), (0...Int.max), (-5...0), (-1...1), (Int.min...Int.max)]
    let ranges2 = [(Int.min..<0), (0..<10), (0..<1000), (0..<Int.max), (-5..<0), (-1..<1), (Int.min..<Int.max)]
    let times = 100
    
    let runTestsOnRange = { (range: Any) -> Void in
      var randoms: [Int] = []
      
      (0...times).forEach({ _ in
        
        let checkRange = { (random: Int, lowerBound: Int, upperBound: Int) in
          XCTAssertGreaterThanOrEqual(random, lowerBound, "Random number generated was less than the lower limit")
          XCTAssertLessThan(random, upperBound, "Random number generated was greater than the upper limit")
          //TODO: randoms should be weak, right?
          
          if upperBound == lowerBound || upperBound > lowerBound + 1 {
            randoms.append(random)
          }
        }
        
        if let range = range as? CountableRange<Int> {
          checkRange(range.random, range.lowerBound, range.upperBound)
        } else if let range = range as? CountableClosedRange<Int> {
          let upper = Swift.min(Int(range.upperBound), Int.max - 1)
          checkRange(range.random, range.lowerBound, upper+1)
        }
      })
      print(randoms)
      
      if !randoms.isEmpty {
        XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
      }
    }
    
    for range in ranges1 {
      runTestsOnRange(range)
    }
    for range in ranges2 {
      runTestsOnRange(range)
    }    
  }
}

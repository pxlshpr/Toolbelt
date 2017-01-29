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

class RandomNumbersTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testRandomNumberForARange() {
    
    //TODO: think about handling negatives, UInt32, Int8, Doubles, Floats
    let ranges1 = [(0...10), (0...1000), (0...Int.max)]
    let ranges2 = [(0..<10), (0..<1000), (0..<Int.max)]
    let times = 1000
    
    let doIt = { (Range) -> () range in
      var randoms: [Int] = []
      
      (0...times).forEach({ _ in
        let random = range.random
        XCTAssertGreaterThanOrEqual(random, range.lowerBound, "Random number generated was less than 0")
        //TODO: need to change this if we're handling negative numbers
        XCTAssertLessThanOrEqual(random, range.upperBound, "Random number generated was greater than the limit")
        randoms.append(random)
      })
      print(randoms)
      XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
    }
    
    for range in ranges1 {
    }
  }
}

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
    //TODO: expect errors to be thrown when we have incorrect ranges and too large of a range, and try catch them in tests and throw them accordingly in code
//    let ranges1 = [(0...10), (0...1000), (0...Int.max)]
    let ranges2 = [(0..<10), (0..<1000), (0..<Int.max)]
    let times = 1000
    
    let doIt = { (range: CountableRange<Int>) -> Void in
      var randoms: [Int] = []
      
      (0...times).forEach({ _ in
        let random = try! range.random()
        XCTAssertGreaterThanOrEqual(random, range.lowerBound, "Random number generated was less than 0")
        //TODO: need to change this if we're handling negative numbers
        XCTAssertLessThanOrEqual(random, range.upperBound, "Random number generated was greater than the limit")
        randoms.append(random)
      })
      print(randoms)
      XCTAssertFalse(randoms.containsDuplicates, "Generated random numbers were all equal")
    }
    
    for range in ranges2 {
      doIt(range)
    }
//    for range in ranges2 {
//      doIt(range)
//    }    
    
    let largeRange = 0..<Int.max
    XCTAssertThrowsError(try largeRange.random) { error in
      XCTAssertEqual(error as? ToolbeltError, .overflowError)
    }
  }
}

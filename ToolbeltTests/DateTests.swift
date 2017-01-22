import XCTest
@testable import Toolbelt

class DateTests: XCTestCase {
  
  var testDates: [Date] {
    return [Date(), Date.distantPast, Date.distantFuture, Date.init(timeIntervalSince1970: 0), Date.init(timeIntervalSinceNow: DBL_MAX)]
  }
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testComponent() {
    for date in testDates {
      XCTAssertEqual(date.component(.year), Calendar.current.component(.year, from:date), "Failed to get year component")
      XCTAssertEqual(date.component(.month), Calendar.current.component(.month, from:date), "Failed to get month component")
      XCTAssertEqual(date.component(.day), Calendar.current.component(.day, from:date), "Failed to get day component")
      XCTAssertEqual(date.component(.hour), Calendar.current.component(.hour, from:date), "Failed to get hour component")
      XCTAssertEqual(date.component(.minute), Calendar.current.component(.minute, from:date), "Failed to get minute component")
      XCTAssertEqual(date.component(.second), Calendar.current.component(.second, from:date), "Failed to get second component")
    }
  }
  
  func testYear() { for date in testDates { XCTAssertEqual(date.year, date.component(.year), "Failed to get year component") } }
  func testMonth() { for date in testDates { XCTAssertEqual(date.month, date.component(.month), "Failed to get month component") } }
  func testDay() { for date in testDates { XCTAssertEqual(date.day, date.component(.day), "Failed to get day component") } }
  func testHour() { for date in testDates { XCTAssertEqual(date.hour, date.component(.hour), "Failed to get hour component") } }
  func testMinute() { for date in testDates { XCTAssertEqual(date.minute, date.component(.minute), "Failed to get minute component") } }
  func testSecond() { for date in testDates { XCTAssertEqual(date.second, date.component(.second), "Failed to get second component") } }
  
  func testStartOfDay() {
    for date in testDates {
      let year = Calendar.current.component(.year, from: date.startOfDay)
      let month = Calendar.current.component(.month, from: date.startOfDay)
      let day = Calendar.current.component(.day, from: date.startOfDay)
      let hour = Calendar.current.component(.hour, from: date.startOfDay)
      let minute = Calendar.current.component(.minute, from: date.startOfDay)
      let second = Calendar.current.component(.second, from: date.startOfDay)
      
      XCTAssertEqual(year, date.year, "Incorrect year in startOfDay")
      XCTAssertEqual(month, date.month, "Incorrect month in startOfDay")
      XCTAssertEqual(day, date.day, "Incorrect day in startOfDay")
      XCTAssertEqual(hour, 0, "Incorrect hour in startOfDay")
      XCTAssertEqual(minute, 0, "Incorrect minute in startOfDay")
      XCTAssertEqual(second, 0, "Incorrect second in startOfDay")
    }
  }
}

import XCTest
@testable import Toolbelt

/*
class ConcurrencyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testThatItRunsAfterADelay() {
        PRIVATE_testThatItRunsAfterADelay { }
    }
    
    // MARK: - 🙈 Private
    
    private func PRIVATE_testThatItRunsAfterADelay(completion: () -> ()) {
        
        let timeout = 20.0
        let delayExpectation = self.expectationWithDescription("Closure delayed")
        
        // given
        let startTime = NSDate().timeIntervalSince1970
        let presetDelay = 1.0
        
        // when
        delay(presetDelay) {
            delayExpectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(timeout) { (error: NSError?) -> () in
            XCTAssertNil(error, "Expectation wasn't fulfilled: \(error?.description)")
            
            // then
            let endTime = NSDate().timeIntervalSince1970
            let measuredDelay = endTime - startTime
            print("measured delay was \(measuredDelay)")
            XCTAssertGreaterThanOrEqual(measuredDelay, presetDelay)
        }
        
    }
    
    
    // MARK: - ❌ Disabled
    
    // Unable to include a test for these functions yet, as:
    // 1. qos_class_self() doesn't return the correct value in the simulator, as GCD isn't simulated properly. see https://github.com/duemunk/Async/issues/38
    // 2. We're unable to run logical tests on the device (as this is a framework and not an app)
    
    func DISABLED_testThatItRunsInTheBackground() {
        
        // given
        let previousClass = qos_class_self()
        
        // when
        background {
            
            //then
            let currentClass = qos_class_self()
            XCTAssertNotEqual(previousClass.rawValue, currentClass.rawValue)
        }
    }
    
    func testThatItRunsInTheBackgroundAfterADelay() {
        PRIVATE_testThatItRunsAfterADelay {
            self.DISABLED_testThatItRunsInTheBackground()
        }
    }
}
*/
import XCTest
import FBSnapshotTestCase
import Toolbelt
import UIKit

class UITests: FBSnapshotTestCase {
  
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    XCUIApplication().launch()
//    recordMode = true
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testExample() {
    FBSnapshotVerifyView(slideshow)
  }
  
  
  //MARK: ---
  
  lazy var slideshow: Slideshow = {
    let slideshow = Slideshow()
    slideshow.frame = CGRect(x: 0, y: 0, width: 350.0, height: 233.0)
    slideshow.showIndicators = true
    let imageURLs = [
      URL(string: "https://travelescapesmaldives.com/wp-content/uploads/2017/06/Meeru-Island-Resort-and-Spa-Garden-Room.jpg")!,
      URL(string: "https://travelescapesmaldives.com/wp-content/uploads/2017/06/Meeru-Island-Resort-and-Spa-Garden-Room-bathroom.jpg")!,
      URL(string: "https://travelescapesmaldives.com/wp-content/uploads/2017/06/Meeru-Island-Resort-and-Spa-Garden-Room-bedroom.jpg")!,
      ]
    //TODO: load local images here or just raw Cocoa APIs
    slideshow.setupWithImages()
    return slideshow
  }()
}

extension Slideshow {
  
  func setupWithImages() {
    self.numberOfImages = 3
    guard self.numberOfImages == imageViews.count else {
      fatalError("Not enough imageViews; expected \(self.numberOfImages), but got \(imageViews.count)")
    }
    for i in 0..<3 {
      let filename = "\(i+2).png"
      let bundle = Bundle(for: UITests.self)
      let image = UIImage(named: filename, in: bundle, compatibleWith: nil)
      guard image != nil else {
        fatalError("Couldn't read image \(filename)")
      }
      imageViews[i].image = image
    }
  }
}

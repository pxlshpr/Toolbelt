import XCTest
import FBSnapshotTestCase
import Toolbelt
import UIKit

enum K {
  static let numberOfTestImages = 12
}

class SlideshowUITests: FBSnapshotTestCase {
  
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    XCUIApplication().launch()
//    recordMode = true
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testCreateSlideshow() {
    
    let slideshow = Slideshow(withImages: images)
    slideshow.frame = CGRect(x: 0, y: 0, width: 350.0, height: 233.0)
    slideshow.shouldShowIndicators = true
    
    FBSnapshotVerifyView(slideshow, identifier: "First image")

    slideshow.selectedImageIndex = slideshow.numberOfImages/2
    FBSnapshotVerifyView(slideshow, identifier: "Middle image")

    slideshow.selectedImageIndex = slideshow.numberOfImages-1
    FBSnapshotVerifyView(slideshow, identifier: "Last image")
  }
  
  
  //MARK: ---
  
  lazy var images: [UIImage] = {
    var images: [UIImage] = []
    for i in 0..<K.numberOfTestImages {
      let filename = "\(i+1).jpg"
      let bundle = Bundle(for: SlideshowUITests.self)
      let image = UIImage(named: filename, in: bundle, compatibleWith: nil)
      if let image = image {
        images.append(image)
      } else {
        fatalError("Couldn't read image \(filename)")
      }
    }
    return images
  }()
  
}

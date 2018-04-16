import XCTest
import FBSnapshotTestCase
import Toolbelt
import UIKit

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
  
  func testCreateSlideshowWithImages_FirstImage() {
    let slideshow = createSlideshow()
    verifySlideshow(slideshow,
                    atIndex: 0,
                    withIdentifier: "First Image")
  }
  
  func testCreateSlideshowWithImages_MiddleImage() {
    let slideshow = createSlideshow()
    verifySlideshow(slideshow,
                    atIndex: slideshow.numberOfImages/2,
                    withIdentifier: "Middle Image")
  }
  
  func testCreateSlideshowWithImages_LastImage() {
    let slideshow = createSlideshow()
    verifySlideshow(slideshow,
                    atIndex: slideshow.numberOfImages-1,
                    withIdentifier: "Last Image")
  }
  
  func testCreateSlideshowFirstThenAssignImages_FirstImage() {
    let slideshow = createSlideshowFirstThenAssignImages()
    verifySlideshow(slideshow,
                    atIndex: 0,
                    withIdentifier: "First Image")
  }
  
  func testCreateSlideshowFirstThenAssignImages_MiddleImage() {
    let slideshow = createSlideshowFirstThenAssignImages()
    verifySlideshow(slideshow,
                    atIndex: slideshow.numberOfImages/2,
                    withIdentifier: "Middle Image")
  }
  
  func testCreateSlideshowFirstThenAssignImages_LastImage() {
    let slideshow = createSlideshowFirstThenAssignImages()
    verifySlideshow(slideshow,
                    atIndex: slideshow.numberOfImages-1,
                    withIdentifier: "Last Image")
  }
    
  func testCreateSlideshowWithIndicatorsAndImages_FirstImage() {
    let slideshow = createSlideshowWithIndicatorsAndImages()
    verifySlideshow(slideshow,
                    atIndex: 0,
                    withIdentifier: "First Image")
  }
  
  func testCreateSlideshowWithIndicatorsAndImages_MiddleImage() {
    let slideshow = createSlideshowWithIndicatorsAndImages()
    verifySlideshow(slideshow,
                    atIndex: slideshow.numberOfImages/2,
                    withIdentifier: "Middle Image")
  }
  
  func testCreateSlideshowWithIndicatorsAndImages_LastImage() {
    let slideshow = createSlideshowWithIndicatorsAndImages()
    verifySlideshow(slideshow,
                    atIndex: slideshow.numberOfImages-1,
                    withIdentifier: "Last Image")
  }


  func testCreateSlideshowWithIndicatorsFirstThenAssignImages_FirstImage() {
    let slideshow = createSlideshowWithIndicatorsFirstThenAssignImages()
    verifySlideshow(slideshow,
                    atIndex: 0,
                    withIdentifier: "First Image")
  }
  
  func testCreateSlideshowWithIndicatorsFirstThenAssignImages_MiddleImage() {
    let slideshow = createSlideshowWithIndicatorsFirstThenAssignImages()
    verifySlideshow(slideshow,
                    atIndex: slideshow.numberOfImages/2,
                    withIdentifier: "Middle Image")
  }
  
  func testCreateSlideshowWithIndicatorsFirstThenAssignImages_LastImage() {
    let slideshow = createSlideshowWithIndicatorsFirstThenAssignImages()
    verifySlideshow(slideshow,
                    atIndex: slideshow.numberOfImages-1,
                    withIdentifier: "Last Image")
  }

  // MARK: - Helpers
  private func verifySlideshow(_ slideshow: Slideshow, atIndex index: Int, withIdentifier identifier: String) {
    slideshow.scrollToIndex(index)
    FBSnapshotVerifyView(slideshow, identifier: identifier)
  }

  private func createSlideshowWithIndicatorsFirstThenAssignImages() -> Slideshow {
    let slideshow = Slideshow(showsIndicators: true)
    slideshow.frame = K.frame
    slideshow.setupWithImages(images)
    return slideshow
  }

  private func createSlideshowWithIndicatorsAndImages() -> Slideshow {
    let slideshow = Slideshow(withImages: images, showsIndicators: true)
    slideshow.frame = K.frame
    return slideshow
  }
  
  private func createSlideshow() -> Slideshow {
    let slideshow = Slideshow(withImages: images)
    slideshow.frame = K.frame
    return slideshow
  }

  private func createSlideshowFirstThenAssignImages() -> Slideshow {
    let slideshow = Slideshow()
    slideshow.frame = K.frame
    slideshow.setupWithImages(images)
    return slideshow
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

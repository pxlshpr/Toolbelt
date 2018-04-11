import UIKit
import Toolbelt

class ViewController: UIViewController {

  lazy var slideshow: Slideshow = {
    let slideshow = Slideshow()
    slideshow.frame = CGRect(x: 0, y: 0, width: 350.0, height: 233.0)
    slideshow.shouldShowIndicators = true
     //TODO: load local images here or just raw Cocoa APIs
    slideshow.setupWithImages()
    return slideshow
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(slideshow)
    slideshow.center = view.center
  }
}

extension Slideshow {
  
  func setupWithImages() {
    let numberOfImages = 12
    self.numberOfImages = numberOfImages
    guard self.numberOfImages == imageViews.count else {
      fatalError("Not enough imageViews; expected \(self.numberOfImages), but got \(imageViews.count)")
    }
    for i in 0..<numberOfImages {
      let filename = "\(i+1).jpg"
      let image = UIImage(named: filename)
//      let image = UIImage(named: filename, in: bundle, compatibleWith: nil)
      guard image != nil else {
        fatalError("Couldn't read image \(filename)")
      }
      imageViews[i].image = image
    }
  }}

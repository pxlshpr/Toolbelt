import UIKit
import Toolbelt

class ViewController: UIViewController {

  lazy var slideshow: Slideshow = {
    let slideshow = Slideshow(withImages: images, showsIndicators: true)
    slideshow.frame = CGRect(x: 0, y: 0, width: 350.0, height: 233.0)
    return slideshow
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(slideshow)
    slideshow.center = view.center
    slideshow.startScrolling()
  }
  
  lazy var images: [UIImage] = {
    var images: [UIImage] = []
    for i in 0..<12 {
      let filename = "\(i+1).jpg"
      let bundle = Bundle(for: ViewController.self)
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

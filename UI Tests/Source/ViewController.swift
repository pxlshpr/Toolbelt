import UIKit
import Toolbelt

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    let slideshow = Slideshow(withImages: images, showsIndicators: true)
    slideshow.frame = K.frame
    view.addSubview(slideshow)

    slideshow.center = view.center
  }

  lazy var images: [UIImage] = {
    var images: [UIImage] = []
    for i in 0..<K.numberOfTestImages {
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

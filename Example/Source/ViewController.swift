import UIKit
import Toolbelt

class ViewController: UIViewController {

  lazy var slideshow: Slideshow = {
    let urlStrings = [
      "http://lorempixel.com/1200/1200/sports/1",
      "http://lorempixel.com/1200/1200/sports/2",
      "http://lorempixel.com/1200/1200/sports/3",
      "http://lorempixel.com/1200/1200/sports/5",
      "http://lorempixel.com/1200/1200/sports/6",
      "http://lorempixel.com/1200/1200/people/1",
      "http://lorempixel.com/1200/1200/people/2",
      "http://lorempixel.com/1200/1200/people/3",
      "http://lorempixel.com/1200/1200/people/5",
      "http://lorempixel.com/1200/1200/people/6"
    ]
    let urls = urlStrings.map { URL.init(string: $0) }.compactMap { $0 }
    let slideshow = Slideshow(withImageURLs: urls, showsIndicators: true)
//    let slideshow = Slideshow(withImages: images, showsIndicators: true)
    slideshow.translatesAutoresizingMaskIntoConstraints = false
    return slideshow
  }()
  
  lazy var button: UIView = {
    let button = UIButton(type: .custom)
    button.setTitle("Press Me", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
    button.setTitleColor(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), for: .normal)
    return button
  }()
  
  @objc func tappedButton() {
//    slideshow.indicatorsView.doIt()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(slideshow)
    view.addSubview(button)
    
    let constraints = [
      NSLayoutConstraint(item: slideshow, attribute: .centerX,
                         relatedBy: .equal,
                         toItem: view, attribute: .centerX,
                         multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: slideshow, attribute: .centerY,
                         relatedBy: .equal,
                         toItem: view, attribute: .centerY,
                         multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: slideshow, attribute: .width,
                         relatedBy: .equal,
                         toItem: nil, attribute: .notAnAttribute,
                         multiplier: 1.0, constant: 350.0),
      NSLayoutConstraint(item: slideshow, attribute: .height,
                         relatedBy: .equal,
                         toItem: nil, attribute: .notAnAttribute,
                         multiplier: 1.0, constant: 233.0),

      NSLayoutConstraint(item: button, attribute: .top,
                         relatedBy: .equal,
                         toItem: slideshow, attribute: .bottom,
                         multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: button, attribute: .centerX,
                         relatedBy: .equal,
                         toItem: slideshow, attribute: .centerX,
                         multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: button, attribute: .height,
                         relatedBy: .equal,
                         toItem: nil, attribute: .notAnAttribute,
                         multiplier: 1.0, constant: 40.0),
      NSLayoutConstraint(item: button, attribute: .width,
                         relatedBy: .equal,
                         toItem: nil, attribute: .notAnAttribute,
                         multiplier: 1.0, constant: 350.0),

    ]
    NSLayoutConstraint.activate(constraints)
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

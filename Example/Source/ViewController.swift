import UIKit
import Toolbelt

class ViewController: UIViewController {

  lazy var slideshow: Slideshow = {
    let slideshow = Slideshow()
    let imageURLs = [
      URL(string: "https://travelescapesmaldives.com/wp-content/uploads/2017/06/Meeru-Island-Resort-and-Spa-Garden-Room.jpg")!,
      URL(string: "https://travelescapesmaldives.com/wp-content/uploads/2017/06/Meeru-Island-Resort-and-Spa-Garden-Room-bathroom.jpg")!,
      URL(string: "https://travelescapesmaldives.com/wp-content/uploads/2017/06/Meeru-Island-Resort-and-Spa-Garden-Room-bedroom.jpg")!,
      ]
    //TODO: load local images here or just raw Cocoa APIs
//    slideshow.setupWithImageURLs(imageURLs)
    return slideshow
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(slideshow)
//    slideshow.width(300)
//    slideshow.height(100)
//    slideshow.center(in: view)
  }
}



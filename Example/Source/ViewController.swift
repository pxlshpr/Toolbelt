import UIKit
import Toolbelt

class ViewController: UIViewController {

  lazy var slideshow: Slideshow = {
    let slideshow = Slideshow()
    slideshow.frame = CGRect(x: 0, y: 0, width: 350.0, height: 233.0)
    let imageURLs = [
      URL(string: "https://travelescapesmaldives.com/wp-content/uploads/2017/06/Meeru-Island-Resort-and-Spa-Garden-Room.jpg")!,
      URL(string: "https://travelescapesmaldives.com/wp-content/uploads/2017/06/Meeru-Island-Resort-and-Spa-Garden-Room-bathroom.jpg")!,
      URL(string: "https://travelescapesmaldives.com/wp-content/uploads/2017/06/Meeru-Island-Resort-and-Spa-Garden-Room-bedroom.jpg")!,
      ]
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
    self.numberOfImages = 4
    guard self.numberOfImages == imageViews.count else {
      fatalError("Not enough imageViews; expected \(self.numberOfImages), but got \(imageViews.count)")
    }
    imageViews[0].image = #imageLiteral(resourceName: "2")
    imageViews[1].image = #imageLiteral(resourceName: "1")
    imageViews[2].image = #imageLiteral(resourceName: "3")
    imageViews[3].image = #imageLiteral(resourceName: "4")
  }
}

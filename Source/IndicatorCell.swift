import UIKit

enum IndicatorType {
  case selected
  case end
  case normal
  
  var size: CGFloat {
    switch self {
    case .selected: return 8.0
    case .end: return 4.0
    case .normal: return 6.0
    }
  }
  
  var color: UIColor {
    switch self {
    case .selected: return .white
    default: return #colorLiteral(red: 0.8941176471, green: 0.8941176471, blue: 0.8941176471, alpha: 1)
    }
  }
}

class IndicatorCell: UICollectionViewCell {
  
  var dimensionConstraints: [NSLayoutConstraint] = []
  var circleView: UIView = UIView()
  var type: IndicatorType = .normal {
    didSet {
      NSLayoutConstraint.deactivate(dimensionConstraints)
      dimensionConstraints = [
        NSLayoutConstraint(item: circleView, attribute: .width,
                           relatedBy: .equal,
                           toItem: nil, attribute: .notAnAttribute,
                           multiplier: 1.0, constant: type.size),
        NSLayoutConstraint(item: circleView, attribute: .height,
                           relatedBy: .equal,
                           toItem: nil, attribute: .notAnAttribute,
                           multiplier: 1.0, constant: type.size)
      ]
      NSLayoutConstraint.activate(dimensionConstraints)
//      circleView.backgroundColor = type.color
      circleView.layer.cornerRadius = type.size / 2.0
    }
  }
  
  func makeCircle() {
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addCircleView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func addCircleView() {
    circleView = createCircleViewWithFrame(self.frame)
    addSubview(circleView)
    
    NSLayoutConstraint.activate([
      NSLayoutConstraint(item: circleView, attribute: .centerX,
                         relatedBy: .equal,
                         toItem: self, attribute: .centerX,
                         multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: circleView, attribute: .centerY,
                         relatedBy: .equal,
                         toItem: self, attribute: .centerY,
                         multiplier: 1.0, constant: 0.0)
      ])
    self.type = .normal
  }
  
  func createCircleViewWithFrame(_ frame: CGRect) -> UIView {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.frame = frame
    view.backgroundColor = .green
    view.alpha = 0.96
    view.clipsToBounds = true
    
    let blurEffect = UIBlurEffect(style: .light)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    //always fill the view
    blurEffectView.frame = frame
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    view.addSubview(blurEffectView)
    
    return view
  }
}

//import UIKit
//import TinyConstraints
//import Toolbelt
//
//class ResortCollectionViewCell: UICollectionViewCell {
//
//  weak var delegate: SlideshowDelegate?
//  var resort: Resort?
//
//  // MARK: - Subviews
//  lazy var slideshow: Slideshow = {
//    let slideshow = createSlideshow()
//    return slideshow
//  }()
//
//  lazy var subtitleContainer: UIView = {
//    let view = UIView()
//    view.backgroundColor = .clear
//    return view
//  }()
//
//  lazy var subtitleLabel: UILabel = {
//    return ResortCollectionViewCell.labelForSubtitle()
//  }()
//
//  lazy var titleLabel: UILabel = {
//    return ResortCollectionViewCell.labelForTitle()
//  }()
//
//  lazy var titleContainer: UIView = {
//    let view = UIView()
//    view.backgroundColor = .clear
//    return view
//  }()
//
//  lazy var stackView: UIStackView = {
//    let stackView = UIStackView(arrangedSubviews: [slideshow, subtitleContainer, titleContainer])
//    stackView.axis = .vertical
//    //    stackView.distribution = .equalSpacing
//    stackView.distribution = .fill
//    stackView.spacing = 0.0
//    return stackView
//  }()
//
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//    addSubviews()
//    addConstraints()
//  }
//
//  required init?(coder aDecoder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//
//  // MARK: - Setup
//  func setup(withResort resort: Resort) {
//    self.resort = resort
//    configureSubviews(withResort: resort)
//  }
//
//  var widthConstraint: NSLayoutConstraint = NSLayoutConstraint()
//  var slideshowHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
//
//  func calculateWidth() -> CGFloat {
//    if Device.isIpad {
//      let sides = (2.0 * 64.0)
//      let middle = 24.0
//      let padding: CGFloat = CGFloat(sides + middle)
//      return (UIScreen.main.bounds.width - padding)/2.0
//    } else {
//      let sides: CGFloat = (2.0 * 24.0)
//      return UIScreen.main.bounds.width - sides
//    }
//  }
//
//  func addConstraints() {
//    let width = calculateWidth()
//    widthConstraint = contentView.width(width)
//    slideshowHeightConstraint = slideshow.height(width/1.5)
//    //    slideshow.height(Device.isIphone ? 218.0 : 330.0)
//
//    stackView.topToSuperview(offset: 0.0)
//    stackView.leftToSuperview(offset: 0.0)
//    stackView.rightToSuperview(offset: 0.0)
//    stackView.bottomToSuperview(offset: 0.0)
//
//    //    stackView.topToSuperview(offset: 18.0)
//    //    stackView.leftToSuperview(offset: 23.0)
//    //    stackView.rightToSuperview(offset: 23.0)
//    //    stackView.bottomToSuperview(offset: -6.0)
//
//    subtitleLabel.topToSuperview(offset: 16.0)
//    subtitleLabel.leftToSuperview()
//    subtitleLabel.rightToSuperview()
//    subtitleLabel.bottomToSuperview(offset: -1.0)
//
//    titleLabel.edgesToSuperviewLegacy()
//  }
//
//  func configureSubviews(withResort resort: Resort) {
//    titleLabel.text = resort.name
//    subtitleLabel.text = resort.typeForCell
//    slideshow.setupWithImageURLs(resort.imageURLs)
//    slideshow.shouldShowIndicators = true
//  }
//
//  override func prepareForReuse() {
//    super.prepareForReuse()
//    self.resort = nil
//    slideshow.prepareForReuse()
//
//    slideshow.imageViews.forEach({ $0.hero.id = nil; $0.hero.modifiers = [] })
//    //    titleContainer.hero.id = nil
//
//    NSLayoutConstraint.deactivate([widthConstraint, slideshowHeightConstraint])
//    let width = calculateWidth()
//    widthConstraint = contentView.width(width)
//    slideshowHeightConstraint = slideshow.height(width/1.5)
//    NSLayoutConstraint.activate([widthConstraint, slideshowHeightConstraint])
//  }
//}
//
//extension ResortCollectionViewCell {
//  static func labelForTitle() -> UILabel {
//    let label = UILabel()
//    label.textAlignment = .left
//    label.font = UIFont(name: "Avenir-Heavy", size: 23.0)
//    label.numberOfLines = 2
//    label.textColor = #colorLiteral(red: 0.3254901961, green: 0.3176470588, blue: 0.3294117647, alpha: 1)
//    return label
//  }
//
//  static func labelForSubtitle() -> UILabel {
//    let label = UILabel()
//    label.textAlignment = .left
//    label.font = UIFont(name: "Avenir-Heavy", size: 12.0)
//    label.numberOfLines = 1
//    label.textColor = #colorLiteral(red: 0.2784313725, green: 0.2823529412, blue: 0.4274509804, alpha: 1)
//    return label
//  }
//
//  func createSlideshow() -> Slideshow {
//    let slideshow = Slideshow(withImages: [])
//    slideshow.layer.cornerRadius = 2.5
//    slideshow.layer.masksToBounds = true
//    return slideshow
//  }
//}
//
//extension ResortCollectionViewCell: SlideshowDelegate {
//
//  func didTapSlideshow(slideshow: Slideshow) {
//    self.delegate?.didTapSlideshow(slideshow: slideshow)
//  }
//
//  func didChangeSelectedImageIndex(to index: Int, onSlideshow slideshow: Slideshow) {
//    self.slideshow.selectedImageIndex = index
//    self.delegate?.didChangeSelectedImageIndex(to: index, onSlideshow: self.slideshow)
//  }
//}
//
//struct Device {
//  static let isIpad = UIDevice.current.userInterfaceIdiom == .pad
//  static let isIphone = UIDevice.current.userInterfaceIdiom == .phone
//  static let isRetina = UIScreen.main.scale >= 2.0
//
//  static let screenWidth = Int(UIScreen.main.bounds.size.width)
//  static let screenHeight = Int(UIScreen.main.bounds.size.height)
//  static let screenMaxLength = Int(max(screenWidth, screenHeight))
//  static let screenMinLength = Int(min(screenWidth, screenHeight))
//
//  static let isIphone4OrLess = isIphone && screenMaxLength  < 568
//  static let isIphone5 = isIphone && screenMaxLength == 568
//  static let isIphone6 = isIphone && screenMaxLength == 667
//  static let isIphone6Plus = isIphone && screenMaxLength == 736
//  static let isIphoneX = isIphone && screenMaxLength == 812
//}
//
//extension ResortCollectionViewCell {
//
//  func removeAsTransitionParticipant() {
//    toggleTransitionStatus(toActive: false)
//  }
//
//  func setAsTransitionParticipant() {
//    toggleTransitionStatus(toActive: true)
//  }
//
//  private func toggleTransitionStatus(toActive: Bool) {
//    if toActive {
//      slideshow.currentImageView?.hero.id = "slideshow"
//      slideshow.currentImageView?.hero.modifiers = [.forceNonFade]
//    } else {
//      slideshow.imageViews.forEach({ $0.hero.id = nil; $0.hero.modifiers = [] })
//    }
//    //    titleContainer.hero.id = toActive ? "titleLabel" : nil
//    subtitleLabel.hero.modifiers = toActive ? [.fade] : nil
//  }
//}

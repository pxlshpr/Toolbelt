import UIKit

extension UIView {
  //TODO: move this to and utilize Sugar here
  func makeCircle() {
    let smallerSide = bounds.width < bounds.height ? bounds.width : bounds.height
    self.layer.cornerRadius = smallerSide / 2.0
  }
}

//MARK: - Class
public class Slideshow: UIView {
  
  public override var intrinsicContentSize: CGSize {
    //TODO: check repurcussions of this
    return CGSize(width: UIScreen.main.bounds.width, height: 220.0)
  }
  
  public var currentIndex: Int = 0 {
    didSet {
      self.layoutIfNeeded()
    }
  }
  
  //MARK: Variables
  public var delegate: SlideshowDelegate?
  public var imageViews: [UIImageView] = []
  
  private var modifiableConstraints: [NSLayoutConstraint] = []
  
  //MARK: Subviews
  lazy var indicators: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear
    view.isUserInteractionEnabled = false
    return view
  }()
  
  var indicatorViews: [UIView] = []
  
  lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.isPagingEnabled = true
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.backgroundColor = .clear
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedSlideshow))
    scrollView.addGestureRecognizer(tapGesture)
    scrollView.delegate = self
    
    if #available(iOS 11, *) {
      scrollView.contentInsetAdjustmentBehavior = .never
    }
    //TODO: mention in README that following line is required on view controller for less than iOS 11
    //    self.automaticallyAdjustsScrollViewInsets = false
    
    return scrollView
  }()
  
  lazy var contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  //MARK: Lifecycle
  public var showIndicators: Bool = false
  
  public var numberOfImages: Int = 0 {
    didSet {
      self.backgroundColor = .clear
      removeSubviews()
      
      addMainSubviews()
      addImageViews()
      if showIndicators {
        addIndicators()
      }
      
      setupMainConstraints()
      setupImageConstraints()
      if showIndicators {
        setupIndicatorConstraints()
      }
      
      scrollView.contentOffset = .zero
    }
  }
  
  //MARK: - Public
  //  public func setupWithImageURLs(_ imageURLs: [URL]) {
  //    prepareForReuse()
  //    imageURLs.forEach { contentView.addSubview(createImageView(withURL: $0)) }
  //    setupConstraints()
  //  }
  
  //TODO: rename this
  public func currentImage() -> UIImage? {
    //TODO: return the actual current image depeneding on which one has been selected, do this along with the indicator
    guard currentIndex < imageViews.count else { return nil }
    return self.imageViews[currentIndex].image
  }
  
  public func prepareForNumberOfImages(_ numberOfImages: Int) {
    //cleanup code
    self.numberOfImages = numberOfImages
    self.addImageViews()
  }
  
  public func prepareForReuse() {
    //TODO: remember contentOffset when reusing (but selectedIndex or something instead)
    scrollView.contentOffset = .zero
  }
  
  public override func layoutIfNeeded() {
    super.layoutIfNeeded()
    setScrollViewContentOffsetBasedOnCurrentIndex()
    indicatorViews.forEach { $0.makeCircle() }
  }
}

//MARK: - Private
extension Slideshow {
  
  private func removeSubviews() {
    imageViews.forEach { $0.removeFromSuperview() }
    contentView.removeFromSuperview()
    scrollView.removeFromSuperview()
    
    indicators.removeFromSuperview()
    indicatorViews.forEach { $0.removeFromSuperview() }
    
    imageViews = []
    indicatorViews = []
  }
  
  private func addImageViews() {
    for _ in 0..<numberOfImages {
      contentView.addSubview(createImageView())
    }
  }
  
  private func addIndicators() {
    addSubview(indicators)
    for _ in 0..<numberOfImages {
      let indicator = createIndicator()
      indicators.addSubview(indicator)
      indicatorViews.append(indicator)
    }
  }
  
  private func addMainSubviews() {
    guard scrollView.superview == nil else {
      return
    }
    addSubview(scrollView)
    scrollView.addSubview(contentView)
  }
  
  private func setScrollViewContentOffsetBasedOnCurrentIndex() {
    let newOffset = CGPoint(x: CGFloat(self.currentIndex) * scrollView.bounds.width, y: 0)
    scrollView.setContentOffset(newOffset, animated: false)
  }
  
  private func createIndicator() -> UIView {
    let indicator = UIView()
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.backgroundColor = .white
    return indicator
  }
  
  private func createImageView() -> UIImageView {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageViews.append(imageView)
    return imageView
  }
}

extension Slideshow: UIScrollViewDelegate {
  
  public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    currentIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    self.delegate?.didChangeCurrentIndex(to: currentIndex, onSlideshow: self)
  }
}

//MARK: - Actions
@objc extension Slideshow {
  func tappedSlideshow() {
    self.delegate?.didTapSlideshow(slideshow: self)
  }
}

extension Slideshow {
  
  fileprivate func setupIndicatorConstraints() {
    
    for i in 0..<indicatorViews.endIndex {
      let indicator = indicatorViews[i]
      
      NSLayoutConstraint.activate([
        //        indicator.topToSuperview()
        NSLayoutConstraint(item: indicator, attribute: .top,
                           relatedBy: .equal,
                           toItem: indicators, attribute: .top,
                           multiplier: 1.0, constant: 0.0),
        //        indicator.bottomToSuperview()
        NSLayoutConstraint(item: indicator, attribute: .bottom,
                           relatedBy: .equal,
                           toItem: indicators, attribute: .bottom,
                           multiplier: 1.0, constant: 0.0),
        //        indicator.height(8.0)
        NSLayoutConstraint(item: indicator, attribute: .height,
                           relatedBy: .equal,
                           toItem: nil, attribute: .notAnAttribute,
                           multiplier: 1.0, constant: 8.0),
        //        indicator.width(8.0)
        NSLayoutConstraint(item: indicator, attribute: .width,
                           relatedBy: .equal,
                           toItem: indicator, attribute: .height,
                           multiplier: 1.0, constant: 0.0)
        ])
      
      if i == 0 {
        NSLayoutConstraint.activate([
          //          indicator.leftToSuperview()
          NSLayoutConstraint(item: indicator, attribute: .left,
                             relatedBy: .equal,
                             toItem: indicators, attribute: .left,
                             multiplier: 1.0, constant: 0.0)
          ])
      } else {
        NSLayoutConstraint.activate([
          //          indicator.leftToRight(of: indicatorViews[i-1], offset: 7.0)
          NSLayoutConstraint(item: indicator, attribute: .left,
                             relatedBy: .equal,
                             toItem: indicatorViews[i-1], attribute: .right,
                             multiplier: 1.0, constant: 7.0)
          ])
      }
      
      if i == indicatorViews.endIndex - 1 {
        NSLayoutConstraint.activate([
          //          indicator.rightToSuperview()
          NSLayoutConstraint(item: indicator, attribute: .right,
                             relatedBy: .equal,
                             toItem: indicators, attribute: .right,
                             multiplier: 1.0, constant: 0.0)
          ])
      }
    }
    
    NSLayoutConstraint.activate([
      //      indicators.bottom(to: self, offset: -8)
      NSLayoutConstraint(item: indicators, attribute: .bottom,
                         relatedBy: .equal,
                         toItem: self, attribute: .bottom,
                         multiplier: 1.0, constant: -8.0),
      //      indicators.centerXToSuperview()
      NSLayoutConstraint(item: indicators, attribute: .centerX,
                         relatedBy: .equal,
                         toItem: self, attribute: .centerX,
                         multiplier: 1.0, constant: 0.0)
      ])
  }
  
  fileprivate func setupMainConstraints() {
    NSLayoutConstraint.activate([
      //      scrollView.left(to: self)
      NSLayoutConstraint(item: scrollView, attribute: .left,
                         relatedBy: .equal,
                         toItem: self, attribute: .left,
                         multiplier: 1.0, constant: 0.0),
      //      scrollView.right(to: self)
      NSLayoutConstraint(item: scrollView, attribute: .right,
                         relatedBy: .equal,
                         toItem: self, attribute: .right,
                         multiplier: 1.0, constant: 0.0),
      //      scrollView.bottom(to: self)
      NSLayoutConstraint(item: scrollView, attribute: .bottom,
                         relatedBy: .equal,
                         toItem: self, attribute: .bottom,
                         multiplier: 1.0, constant: 0.0)
      ])
    
    NSLayoutConstraint.activate([
      NSLayoutConstraint(item: contentView, attribute: .top,
                         relatedBy: .equal,
                         toItem: scrollView, attribute: .top,
                         multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: scrollView, attribute: .top,
                         relatedBy: .equal,
                         toItem: self, attribute: .top,
                         multiplier: 1.0, constant: 0)
      ])
    
    NSLayoutConstraint.activate([
      NSLayoutConstraint(item: contentView, attribute: .left,
                         relatedBy: .equal,
                         toItem: scrollView, attribute: .left,
                         multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: contentView, attribute: .right,
                         relatedBy: .equal,
                         toItem: scrollView, attribute: .right,
                         multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: contentView, attribute: .bottom,
                         relatedBy: .equal,
                         toItem: scrollView, attribute: .bottom,
                         multiplier: 1.0, constant: 0.0),
      ])
    
    let widthConstraint = NSLayoutConstraint(item: contentView, attribute: .width,
                                             relatedBy: .equal,
                                             toItem: scrollView, attribute: .width,
                                             multiplier: 1.0, constant: 0.0)
    widthConstraint.priority = .defaultLow
    NSLayoutConstraint.activate([widthConstraint])
  }
  
  fileprivate func setupImageConstraints() {
    for i in 0..<imageViews.endIndex {
      let imageView = imageViews[i]
      
      NSLayoutConstraint.activate([
        NSLayoutConstraint(item: imageView, attribute: .top,
                           relatedBy: .equal,
                           toItem: contentView, attribute: .top,
                           multiplier: 1.0, constant: 0.0),
        NSLayoutConstraint(item: imageView, attribute: .width,
                           relatedBy: .equal,
                           toItem: scrollView, attribute: .width,
                           multiplier: 1.0, constant: 0.0),
        NSLayoutConstraint(item: imageView, attribute: .height,
                           relatedBy: .equal,
                           toItem: scrollView, attribute: .height,
                           multiplier: 1.0, constant: 0.0)
        ])
      if imageView == imageViews.first {
        NSLayoutConstraint.activate([
          NSLayoutConstraint(item: imageView, attribute: .left,
                             relatedBy: .equal,
                             toItem: contentView, attribute: .left,
                             multiplier: 1.0, constant: 0.0)
          ])
      } else {
        NSLayoutConstraint.activate([
          NSLayoutConstraint(item: imageView, attribute: .left,
                             relatedBy: .equal,
                             toItem: imageViews[i-1], attribute: .right,
                             multiplier: 1.0, constant: 0.0)
          ])
      }
      
      if imageView == imageViews.last {
        NSLayoutConstraint.activate([
          NSLayoutConstraint(item: imageView, attribute: .right,
                             relatedBy: .equal,
                             toItem: contentView, attribute: .right,
                             multiplier: 1.0, constant: 0.0)
          ])
      }
    }
  }
}

//MARK: - Protocol
public protocol SlideshowDelegate {
  func didTapSlideshow(slideshow: Slideshow)
  func didChangeCurrentIndex(to currentIndex: Int, onSlideshow slideshow: Slideshow)
}



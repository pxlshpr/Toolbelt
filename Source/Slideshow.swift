import UIKit

//MARK: - Class
public class Slideshow: UIView {
  
  //MARK: - Public (Variables)
  public weak var delegate: SlideshowDelegate?
  public var imageViews: [UIImageView] = []
  public var selectedImageIndex: Int = 0 {
    didSet {
      indicatorsView.selectedIndicatorIndex = selectedImageIndex
      indicatorsView.reloadData()
      
      let offset = CGPoint(x: CGFloat(selectedImageIndex) * frame.width, y: 0)
      self.scrollView.setContentOffset(offset, animated: true)
//      self.layoutIfNeeded()
      
      self.delegate?.didChangeSelectedImageIndex(to: selectedImageIndex, onSlideshow: self)
    }
  }
  public var numberOfImages: Int = 0 {
    didSet {
      setup()
    }
  }
  var timer: Timer?
  var shouldScrollAutomatically: Bool = false
  
//  public override var intrinsicContentSize: CGSize {
//    //TODO: check repurcussions of this
//    return CGSize(width: 327.0, height: 218.0) //completely arbitrary numbers
//  }
  
  //MARK: Public (Initializers)
  public init(withImages images: [UIImage] = [], showsIndicators: Bool = false) {
    super.init(frame: .zero)
    self.shouldShowIndicators = showsIndicators
    numberOfImages = images.count
    setup()
    images.forEach({ image in
      guard let index = images.index(of: image) else { return }
      imageViews[index].image = image
    })
  }
  
  private var modifiableConstraints: [NSLayoutConstraint] = []
  private var shouldShowIndicators: Bool = false

  //MARK: Subviews
//  private var indicatorViews: [UIView] = []
  public lazy var indicatorsView: IndicatorsView = {
    let indicatorsView = IndicatorsView()
    indicatorsView.numberOfIndicators = self.numberOfImages
    indicatorsView.translatesAutoresizingMaskIntoConstraints = false
    return indicatorsView
  }()
  
  private lazy var scrollView: UIScrollView = {
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
    // TODO: mention in README that following line is required on view controller for less than iOS 11
//    self.automaticallyAdjustsScrollViewInsets = false
    
    return scrollView
  }()
  
  private lazy var contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var gradientLayer: CAGradientLayer = {
    let layer = CAGradientLayer()
    layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
    return layer
  }()
  
  private lazy var gradientView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.insertSublayer(gradientLayer, at: 0)
    view.isUserInteractionEnabled = false
//    view.backgroundColor = .green
    return view
  }()

  //MARK: Unsorted
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //TODO: rename this
  public func currentImage() -> UIImage? {
    //TODO: return the actual current image depeneding on which one has been selected, do this along with the indicator
    guard selectedImageIndex < imageViews.count else { return nil }
    return self.imageViews[selectedImageIndex].image
  }
  
  public func prepareForReuse() {
    //TODO: remember contentOffset when reusing (but selectedIndex or something instead)
    scrollView.contentOffset = .zero
    self.numberOfImages = 0
    setup()
  }
  
  public func setupWithImages(_ images: [UIImage]) {
    self.prepareForReuse()
    self.numberOfImages = images.count
    imageViews.forEach { imageView in
      guard let index = imageViews.index(of: imageView) else {
        return
      }
      imageViews[index].image = images[index]
    }
  }
  
  public override func layoutIfNeeded() {
    super.layoutIfNeeded()
    setScrollViewContentOffsetBasedOnSelectedImageIndex()
  }

  func restartScrolling() {
    timer = Timer(timeInterval: 3.8, target: self, selector: #selector(restartTimerFired(timer:)), userInfo: nil, repeats: false)
    guard let timer = timer else { return }
    RunLoop.main.add(timer, forMode: .defaultRunLoopMode)
  }
  
  public func startScrolling() {
    shouldScrollAutomatically = true
    startTimer()
  }
  
  func startTimer() {
    timer = Timer(timeInterval: 4.8, target: self, selector: #selector(timerFired(timer:)), userInfo: nil, repeats: true)
    guard let timer = timer else { return }
    RunLoop.main.add(timer, forMode: .defaultRunLoopMode)
  }
  
  public func stopScrolling() {
    shouldScrollAutomatically = false
    stopTimer()
  }
  
  func stopTimer() {
    timer?.invalidate()
    timer = nil
  }
  
  @objc func restartTimerFired(timer: Timer) {
    startTimer()
  }
  
  @objc func timerFired(timer: Timer) {
    if selectedImageIndex == numberOfImages - 1 {
      selectedImageIndex = 0
    } else {
      selectedImageIndex = selectedImageIndex + 1
    }
  }
}

//MARK: - Private
extension Slideshow {
  
  private func setup() {
    self.backgroundColor = .clear
    removeSubviews()
    
    addMainSubviews()
    addImageViews()
    setupMainConstraints()
    setupImageConstraints()
    
    if shouldShowIndicators {
      addIndicators()
      setupIndicatorConstraints()
    }
    indicatorsView.numberOfIndicators = numberOfImages
    indicatorsView.reloadData()
    
    scrollView.contentOffset = .zero
  }
  
  private func removeSubviews() {
    imageViews.forEach { $0.removeFromSuperview() }
    contentView.removeFromSuperview()
    scrollView.removeFromSuperview()
    
    indicatorsView.removeFromSuperview()
    
    imageViews = []
  }
  
  private func addImageViews() {
    for _ in 0..<numberOfImages {
      contentView.addSubview(createImageView())
    }
  }
  
  private func addIndicators() {
    addSubview(gradientView)
    addSubview(indicatorsView)
  }
  
  private func addMainSubviews() {
    guard scrollView.superview == nil else {
      return
    }
    addSubview(scrollView)
    scrollView.addSubview(contentView)
  }
  
  private func setScrollViewContentOffsetBasedOnSelectedImageIndex() {
    let newOffset = CGPoint(x: CGFloat(self.selectedImageIndex) * scrollView.bounds.width, y: 0)
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
    imageView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
    imageViews.append(imageView)
    return imageView
  }
}

extension Slideshow: UIScrollViewDelegate {
  
  public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    indicatorsView.selectedIndicatorIndex = index
    indicatorsView.updateOffsetBasedOnSelectedIndicator()
    indicatorsView.reloadData()
  }
  
  public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    selectedImageIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    if timer == nil && shouldScrollAutomatically {
      startTimer()
    }
    indicatorsView.selectedIndicatorIndex = selectedImageIndex
    indicatorsView.updateOffsetBasedOnSelectedIndicator()
//    indicatorsView.reloadData()
  }
  
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    switch scrollView.panGestureRecognizer.state {
    case .began:
      stopTimer()
    default:
      break
    }
  }
}

//MARK: - Actions
@objc extension Slideshow {
  func tappedSlideshow() {
    self.delegate?.didTapSlideshow(slideshow: self)
  }
}

extension Slideshow {
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    if shouldShowIndicators {
      gradientLayer.frame = CGRect(x: 0, y: 0, width: gradientView.frame.width, height: gradientView.frame.height)
      gradientLayer.locations = [0, 6]
    }
  }
  
  fileprivate func setupIndicatorConstraints() {
    
    NSLayoutConstraint.activate([
 
      NSLayoutConstraint(item: gradientView, attribute: .left,
                         relatedBy: .equal,
                         toItem: self, attribute: .left,
                         multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: gradientView, attribute: .right,
                         relatedBy: .equal,
                         toItem: self, attribute: .right,
                         multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: gradientView, attribute: .bottom,
                         relatedBy: .equal,
                         toItem: self, attribute: .bottom,
                         multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: gradientView, attribute: .top,
                         relatedBy: .equal,
                         toItem: self, attribute: .top,
                         multiplier: 1.0, constant: 0.0),

      NSLayoutConstraint(item: indicatorsView, attribute: .bottom,
                         relatedBy: .equal,
                         toItem: self, attribute: .bottom,
                         multiplier: 1.0, constant: -8.0),
      NSLayoutConstraint(item: indicatorsView, attribute: .centerX,
                         relatedBy: .equal,
                         toItem: self, attribute: .centerX,
                         multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: indicatorsView, attribute: .height,
                         relatedBy: .equal,
                         toItem: nil, attribute: .notAnAttribute,
                         multiplier: 1.0, constant: 8.0),
      NSLayoutConstraint(item: indicatorsView, attribute: .width,
                         relatedBy: .equal,
                         toItem: nil, attribute: .notAnAttribute,
                         multiplier: 1.0, constant: 14.0 * 5.0)
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
public protocol SlideshowDelegate: class {
  func didTapSlideshow(slideshow: Slideshow)
  func didChangeSelectedImageIndex(to index: Int, onSlideshow slideshow: Slideshow)
}



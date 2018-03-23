import UIKit

//MARK: - Protocol
public protocol SlideshowDelegate {
  func didTapSlideshow(slideshow: Slideshow)
  func didChangeCurrentIndex(to currentIndex: Int, onSlideshow slideshow: Slideshow)
}

//MARK: - Class
public class Slideshow: UIView {
  
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
  lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.isPagingEnabled = true
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
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
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  //MARK: Lifecycle
  public var numberOfImages: Int = 0 {
    didSet {
      removeImageViews()
      
      addMainSubviews()
      addImageViews()
      
      setupMainConstraints()
      setupImageConstraints()
      
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
  func currentImage() -> UIImage? {
    //TODO: return the actual current image depeneding on which one has been selected, do this along with the indicator
    return self.imageViews.first?.image
  }
  
  public func prepareForNumberOfImages(_ numberOfImages: Int) {
    //cleanup code
    self.numberOfImages = numberOfImages
    self.addImageViews()
  }
  
  public func prepareForReuse() {
    removeImageViews()
    //TODO: remember contentOffset when reusing (but selectedIndex or something instead)
    scrollView.contentOffset = .zero
  }
  
  public override func layoutIfNeeded() {
    super.layoutIfNeeded()
    setScrollViewContentOffsetBasedOnCurrentIndex()
  }
}

//MARK: - Private
extension Slideshow {
  
  private func removeImageViews() {
    for imageView in imageViews {
      imageView.removeFromSuperview()
    }
    imageViews = []
  }
  
  private func addImageViews() {
    for _ in 0..<numberOfImages {
      contentView.addSubview(createImageView())
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

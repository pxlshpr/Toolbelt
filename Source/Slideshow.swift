import UIKit
import TinyConstraints
import Nuke

//MARK: - Protocol
protocol SlideshowDelegate {
  func didTapSlideshow()
}

//MARK: - Class
public class Slideshow: UIView {
  
  //MARK: Variables
  var delegate: SlideshowDelegate?
  var imageViews: [UIImageView] = []
  
  var constraintsToRemove: [NSLayoutConstraint] = []
  
  //MARK: Subviews
  lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.isPagingEnabled = true
    scrollView.showsHorizontalScrollIndicator = false
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedSlideshow))
    scrollView.addGestureRecognizer(tapGesture)
    return scrollView
  }()
  
  lazy var contentView: UIView = {
    let view = UIView()
    return view
  }()
  
  //MARK: Lifecycle
  convenience init() {
    self.init(frame: .zero)
    
    self.backgroundColor = .blue
    
    //TODO: move this into cell
    self.layer.cornerRadius = K.cornerRadius
    self.layer.masksToBounds = true
    
    setupSubviews()
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    setupConstraints()
  }
  
  //MARK: - Public
  public func setupWithImageURLs(_ imageURLs: [URL]) {
    prepareForReuse()
    imageURLs.forEach { contentView.addSubview(createImageView(withURL: $0)) }
    setupConstraints()
  }
  
  //TODO: rename this
  func currentImage() -> UIImage? {
    //TODO: return the actual current image depeneding on which one has been selected, do this along with the indicator
    return self.imageViews.first?.image
  }
  
  func prepareForReuse() {
    clearImageViews()
    //TODO: remember contentOffset when reusing (but selectedIndex or something instead)
    scrollView.contentOffset = .zero
  }
}

//MARK: - Private
extension Slideshow {
  
  private func setupSubviews() {
    addSubview(scrollView)
    scrollView.addSubview(contentView)
  }
  
  private func setupConstraints() {
    
    NSLayoutConstraint.deactivate(constraintsToRemove)
    
    constraintsToRemove.append(scrollView.left(to: self))
    constraintsToRemove.append(scrollView.right(to: self))
    constraintsToRemove.append(scrollView.bottom(to: self))
    if #available(iOS 11.0, *) {
      //needed to appear below status bar in profile/detail views
      constraintsToRemove.append(scrollView.top(to: self, offset: -safeAreaInsets.top))
    } else {
      constraintsToRemove.append(scrollView.top(to: self))
    }
    
    constraintsToRemove.append(contentView.left(to: scrollView))
    constraintsToRemove.append(contentView.right(to: scrollView))
    constraintsToRemove.append(contentView.top(to: scrollView))
    constraintsToRemove.append(contentView.bottom(to: scrollView))
    constraintsToRemove.append(contentView.width(to: scrollView, priority: .defaultLow))
    
    for i in 0..<imageViews.endIndex {
      let imageView = imageViews[i]
      constraintsToRemove.append(imageView.top(to: contentView))
      constraintsToRemove.append(imageView.width(to: scrollView))
      constraintsToRemove.append(imageView.height(to: scrollView))
      if imageView == imageViews.first {
        constraintsToRemove.append(imageView.leftToSuperview())
      } else {
        constraintsToRemove.append(imageView.leftToRight(of: imageViews[i-1]))
      }
      
      if imageView == imageViews.last {
        constraintsToRemove.append(imageView.right(to: contentView))
      }
    }
  }
  
  private func createImageView(withURL url: URL) -> UIImageView {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageViews.append(imageView)
    Nuke.Manager.shared.loadImage(with: url, into: imageView)
    return imageView
  }
  
  private func clearImageViews() {
    for imageView in imageViews {
      imageView.removeFromSuperview()
    }
    imageViews = []
    
    scrollView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
  }
}

//MARK: - Actions
@objc extension Slideshow {
  func tappedSlideshow() {
    self.delegate?.didTapSlideshow()
  }
}

//MARK: - Constants
extension Slideshow {
  enum K {
    static let cornerRadius: CGFloat = 2.5
  }
}


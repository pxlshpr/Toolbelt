import UIKit
import SwiftyBeaver
import TinyConstraints

let log = SwiftyBeaver.self

//MARK: - Class
public class Slideshow: UIView {
  
  public weak var delegate: SlideshowDelegate?
  public var selectedImageIndex: Int = 0
  
  var shouldShowIndicators: Bool = false
  var timer: Timer?
  var shouldScrollAutomatically: Bool = false
  
  //MARK: Public (Initializers)
  public init(withImageURLs imageURLs: [URL], showsIndicators: Bool = false) {
    let console = ConsoleDestination()
    log.addDestination(console)
    log.info("SwiftyBeaver has been setup")

    super.init(frame: .zero)
    self.shouldShowIndicators = showsIndicators
    self.imagesCollectionView.delegate = self
    self.imagesCollectionView.setupWithURLs(imageURLs)
    setup()
    
  }
  
  var numberOfImages: Int {
    return self.imagesCollectionView.imageURLs.count
  }
  
  //MARK: Subviews
  lazy var indicatorsView: SlideshowIndicatorsCollectionView = {
    let indicatorsView = SlideshowIndicatorsCollectionView()
    indicatorsView.numberOfIndicators = numberOfImages
    indicatorsView.translatesAutoresizingMaskIntoConstraints = false
    return indicatorsView
  }()
  
  lazy var leftTapView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    view.translatesAutoresizingMaskIntoConstraints = false
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedLeft))
    view.addGestureRecognizer(tapRecognizer)
    return view
  }()
  
  lazy var rightTapView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    view.translatesAutoresizingMaskIntoConstraints = false
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedRight))
    view.addGestureRecognizer(tapRecognizer)
    return view
  }()
  
  lazy var imagesCollectionView = SlideshowImagesCollectionView()

//  lazy var scrollView: UIScrollView = {
//    let scrollView = UIScrollView()
//    scrollView.translatesAutoresizingMaskIntoConstraints = false
//    scrollView.isPagingEnabled = true
//    scrollView.showsHorizontalScrollIndicator = false
//    scrollView.backgroundColor = .clear
//    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedSlideshow))
//    scrollView.addGestureRecognizer(tapGesture)
//    scrollView.delegate = self
//
//    if #available(iOS 11, *) {
//      scrollView.contentInsetAdjustmentBehavior = .never
//    }
//    // TODO: mention in README that following line is required on view controller for less than iOS 11
////    self.automaticallyAdjustsScrollViewInsets = false
//
//    return scrollView
//  }()
//
//  lazy var contentView: UIView = {
//    let view = UIView()
//    view.backgroundColor = .clear
//    view.translatesAutoresizingMaskIntoConstraints = false
//    return view
//  }()
  
  //MARK: Unsorted
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //TODO: rename this
  func currentIndex() -> Int {
    return 0
  }
  
  //TODO: make this a var like currentImageView
  public func currentImage() -> UIImage? {
    return currentImageView?.image
  }
  
  public func prepareForReuse() {
    //TODO: remember contentOffset when reusing (but selectedIndex or something instead)
//    scrollView.contentOffset = .zero
    imagesCollectionView.prepareForReuse()
    setup()
  }
    
  public var currentImageView: UIImageView? {
    //TODO: use a FP method like filter, map reduce etc to find this instead of a for loop
    for cell in imagesCollectionView.visibleCells {
      if imagesCollectionView.indexPath(for: cell)?.row == currentIndex(),
        let imageCell = cell as? SlideshowImageCollectionViewCell {
        return imageCell.imageView
      }
    }
    return nil
  }
  
  public override func layoutIfNeeded() {
    super.layoutIfNeeded()
    setScrollViewContentOffsetBasedOnSelectedImageIndex()
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    if let flowLayout = imagesCollectionView.collectionViewLayout
      as? UICollectionViewFlowLayout {
      log.debug("Setting flow layout item size to \(bounds.size)")
      flowLayout.estimatedItemSize = bounds.size
    }
  }
}

//MARK: - Private
extension Slideshow {
  
  private func setup() {
    self.backgroundColor = .clear
    
    removeSubviews()
    addSubview(imagesCollectionView)
    imagesCollectionView.edges(to: self)
    
    if shouldShowIndicators {
      addIndicators()
      setupIndicatorConstraints()
    }
    indicatorsView.numberOfIndicators = numberOfImages
    indicatorsView.reloadData()
    
//    scrollView.contentOffset = .zero
  }
  
  private func removeSubviews() {
//    imageViews.forEach { $0.removeFromSuperview() }
//    contentView.removeFromSuperview()
//    scrollView.removeFromSuperview()
    imagesCollectionView.removeFromSuperview()
    indicatorsView.removeFromSuperview()
    
//    imageViews = []
  }
  
  private func addIndicators() {
//    contentView.addSubview(gradientView)
    
    addSubview(indicatorsView)
    
    addSubview(leftTapView)
    addSubview(rightTapView)
  }
  
  private func setScrollViewContentOffsetBasedOnSelectedImageIndex() {
//    let newOffset = CGPoint(x: CGFloat(self.selectedImageIndex) * scrollView.bounds.width, y: 0)
//    scrollView.setContentOffset(newOffset, animated: false)
  }
}

extension Slideshow: UICollectionViewDelegate {
  
}

extension Slideshow: UIScrollViewDelegate {
  
  public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    indicatorsView.scrollToIndex(index)
  }
  
  public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let newIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    scrollToIndex(newIndex)
    indicatorsView.scrollToIndex(selectedImageIndex)
    if timer == nil && shouldScrollAutomatically {
      startTimer()
    }
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
  
  @objc func tappedLeft() {
    if selectedImageIndex > 0 {
      scrollToIndex(selectedImageIndex - 1)
    }
  }
  
  @objc func tappedRight() {
    if selectedImageIndex < numberOfImages-1 {
      scrollToIndex(selectedImageIndex + 1)
    }
  }
}

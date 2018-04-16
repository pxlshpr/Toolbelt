import UIKit
import TinyConstraints

//MARK: - Class
public class Slideshow: UIView {
  
  public weak var delegate: SlideshowDelegate?
  public var selectedImageIndex: Int = 0
  
  var shouldShowIndicators: Bool = false
  var timer: Timer?
  var shouldScrollAutomatically: Bool = false
  
  //MARK: Public (Initializers)
  public init(withImageURLs imageURLs: [URL], showsIndicators: Bool = false) {
    super.init(frame: .zero)
    self.shouldShowIndicators = showsIndicators
    self.imagesCollectionView.delegate = self
    self.imagesCollectionView.applyGradientToViews = showsIndicators
    setupWithURLs(imageURLs)
    setup()
  }
  
  public func setupWithURLs(_ imageURLs: [URL]) {
    imagesCollectionView.setupWithURLs(imageURLs)
    indicatorsView.setupWithNumberOfIndicators(imageURLs.count)
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
  
  lazy var tapViewContainer: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    view.addSubview(leftTapView)
    view.addSubview(rightTapView)
    return view
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
  
  //MARK: Unsorted
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //TODO: make this a var like currentImageView
  public func currentImage() -> UIImage? {
    return currentImageView?.image
  }
  
  public func prepareForReuse() {
    imagesCollectionView.prepareForReuse()
    indicatorsView.prepareForReuse()
  }
    
  public var currentImageView: UIImageView? {
    //TODO: use a FP method like filter, map reduce etc to find this instead of a for loop
    for cell in imagesCollectionView.visibleCells {
      if imagesCollectionView.indexPath(for: cell)?.row == selectedImageIndex,
        let imageCell = cell as? SlideshowImageCollectionViewCell {
        return imageCell.imageView
      }
    }
    return nil
  }
  
  public override func layoutIfNeeded() {
    super.layoutIfNeeded()
    setContentOffsetBasedOnSelectedImageIndex()
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    if let flowLayout = imagesCollectionView.collectionViewLayout
      as? UICollectionViewFlowLayout {
      flowLayout.estimatedItemSize = bounds.size
    }
  }
}

//MARK: - Private
extension Slideshow {
  
  private func setup() {
    self.backgroundColor = .clear
    addImagesCollectionView()
    if shouldShowIndicators {
      addIndicatorsCollectionView()
    }
  }
  
  private func setContentOffsetBasedOnSelectedImageIndex() {
    let newOffset = CGPoint(x: CGFloat(self.selectedImageIndex) * imagesCollectionView.bounds.width, y: 0)
    imagesCollectionView.setContentOffset(newOffset, animated: false)
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

public protocol SlideshowDelegate: class {
  func didTapSlideshow(slideshow: Slideshow)
  func didChangeSelectedImageIndex(to index: Int, onSlideshow slideshow: Slideshow)
}

import UIKit
import Nuke
import TinyConstraints

class SlideshowImageCollectionViewCell: UICollectionViewCell {
  
  var applyGradient: Bool = false
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(imageView)
    contentView.addSubview(gradientView)
//    imageView.edges(to: contentView)
//    gradientView.edges(to: contentView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
    gradientView.isHidden = true
  }
  
  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.frame = contentView.bounds
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
    return imageView
  }()
  
  lazy var gradientView: GradientView = {
    let view = GradientView()
    view.frame = contentView.bounds
    view.backgroundColor = .clear
    view.isHidden = true
    return view
  }()
  
//  override func layoutSubviews() {
//    super.layoutSubviews()
//  }
  
  // MARK: - Setup
  func setupWithImage(_ image: UIImage) {
    log.verbose("Loading cell with image with dimensions \(image.size.width)px x \(image.size.height)px")
    imageView.image = image
  }
  
  func setupWithImageURL(_ url: URL) {
    log.verbose("Using Nuke to load cell with url: \(url)")
    Nuke.Manager.shared.loadImage(with: url, into: imageView) { [weak imageView]
      (result, isFromMemoryCache) in
      imageView?.handle(response: result, isFromMemoryCache: isFromMemoryCache)
      if self.applyGradient {
        self.gradientView.isHidden = false
      }
    }
  }
}

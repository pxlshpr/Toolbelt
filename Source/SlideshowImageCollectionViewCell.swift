import UIKit
import Nuke

class SlideshowImageCollectionViewCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(imageView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
  }
  
  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.frame = contentView.bounds
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
    return imageView
  }()
  
  // MARK: - Setup
  func setupWithImage(_ image: UIImage) {
    log.verbose("Loading cell with image with dimensions \(image.size.width)px x \(image.size.height)px")
    imageView.image = image
  }
  
  func setupWithImageURL(_ url: URL) {
    log.verbose("Using Nuke to load cell with url: \(url)")
    Nuke.Manager.shared.loadImage(with: url, into: imageView)
  }
}

import UIKit
import Nuke

class SlideshowImageCollectionViewCell: UICollectionViewCell {
  
  var applyGradient: Bool = false
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(imageView)
    contentView.addSubview(gradientView)
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
  
  // MARK: - Setup
  func setupWithImage(_ image: UIImage) {
    imageView.image = image
  }
  
  func setupWithImageURL(_ url: URL) {
    Nuke.Manager.shared.loadImage(with: url, into: imageView) { [weak imageView]
      (result, isFromMemoryCache) in
      imageView?.handle(response: result, isFromMemoryCache: isFromMemoryCache)
      if self.applyGradient {
        self.gradientView.isHidden = false
      }
    }
  }
}

class GradientView: UIView {
  
  private let gradient : CAGradientLayer = CAGradientLayer()
  
  override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
    self.gradient.frame = self.bounds
  }
  
  override public func draw(_ rect: CGRect) {
    self.gradient.frame = self.bounds
    self.gradient.colors = [UIColor.clear.cgColor, #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 0.7480736301).cgColor]
    self.gradient.locations = [0, 5]
    if self.gradient.superlayer == nil {
      self.layer.insertSublayer(self.gradient, at: 0)
    }
  }
}

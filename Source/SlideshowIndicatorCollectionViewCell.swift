import UIKit

class SlideshowIndicatorCollectionViewCell: UICollectionViewCell {

  var circleView: UIView = UIView()
  var type: SlideshowIndicatorType = .normal { didSet { refreshCircleView() } }

  override init(frame: CGRect) {
    super.init(frame: frame)
    addCircleView()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Helpers
  private func addCircleView() {
    circleView = UIView()
    circleView.frame = frame
    circleView.alpha = 0.96
    circleView.clipsToBounds = true
    contentView.addSubview(circleView)
    
    type = .normal
  }
  
  private func refreshCircleView() {
    circleView.frame.size = CGSize(width: type.size, height: type.size)
    circleView.center = contentView.center
    circleView.backgroundColor = type.color
    circleView.layer.cornerRadius = type.size / 2.0
  }
}

import UIKit

class GradientView: UIView {
  
  private let gradient : CAGradientLayer = CAGradientLayer()
  
  override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
    self.gradient.frame = self.bounds
  }
  
  override public func draw(_ rect: CGRect) {
    self.gradient.frame = self.bounds
    self.gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
    self.gradient.locations = [0, 6]
    if self.gradient.superlayer == nil {
      self.layer.insertSublayer(self.gradient, at: 0)
    }
  }
}

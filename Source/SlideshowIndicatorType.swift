import UIKit

enum SlideshowIndicatorType {
  case selected
  case small
  case normal
  
  var size: CGFloat {
    switch self {
    case .selected: return 8.0
    case .small: return 4.0
    case .normal: return 6.0
    }
  }
  
  var color: UIColor {
    switch self {
    case .selected: return .white
    default: return #colorLiteral(red: 0.8941176471, green: 0.8941176471, blue: 0.8941176471, alpha: 1)
    }
  }
}

import UIKit

extension Slideshow {
  
  func setupMainConstraints() {
//    NSLayoutConstraint.activate([
//      //      scrollView.left(to: self)
//      NSLayoutConstraint(item: scrollView, attribute: .left,
//                         relatedBy: .equal,
//                         toItem: self, attribute: .left,
//                         multiplier: 1.0, constant: 0.0),
//      //      scrollView.right(to: self)
//      NSLayoutConstraint(item: scrollView, attribute: .right,
//                         relatedBy: .equal,
//                         toItem: self, attribute: .right,
//                         multiplier: 1.0, constant: 0.0),
//      //      scrollView.bottom(to: self)
//      NSLayoutConstraint(item: scrollView, attribute: .bottom,
//                         relatedBy: .equal,
//                         toItem: self, attribute: .bottom,
//                         multiplier: 1.0, constant: 0.0)
//      ])
//
//    NSLayoutConstraint.activate([
//      NSLayoutConstraint(item: contentView, attribute: .top,
//                         relatedBy: .equal,
//                         toItem: scrollView, attribute: .top,
//                         multiplier: 1.0, constant: 0.0),
//      NSLayoutConstraint(item: scrollView, attribute: .top,
//                         relatedBy: .equal,
//                         toItem: self, attribute: .top,
//                         multiplier: 1.0, constant: 0)
//      ])
//
//    NSLayoutConstraint.activate([
//      NSLayoutConstraint(item: contentView, attribute: .left,
//                         relatedBy: .equal,
//                         toItem: scrollView, attribute: .left,
//                         multiplier: 1.0, constant: 0.0),
//      NSLayoutConstraint(item: contentView, attribute: .right,
//                         relatedBy: .equal,
//                         toItem: scrollView, attribute: .right,
//                         multiplier: 1.0, constant: 0.0),
//      NSLayoutConstraint(item: contentView, attribute: .bottom,
//                         relatedBy: .equal,
//                         toItem: scrollView, attribute: .bottom,
//                         multiplier: 1.0, constant: 0.0),
//      ])
//
//    let widthConstraint = NSLayoutConstraint(item: contentView, attribute: .width,
//                                             relatedBy: .equal,
//                                             toItem: scrollView, attribute: .width,
//                                             multiplier: 1.0, constant: 0.0)
//    widthConstraint.priority = .defaultLow
//    NSLayoutConstraint.activate([widthConstraint])
  }
  
  func setupImageConstraints() {
    //    for i in 0..<imageViews.endIndex {
    //      let imageView = imageViews[i]
    //
    //      NSLayoutConstraint.activate([
    //        NSLayoutConstraint(item: imageView, attribute: .top,
    //                           relatedBy: .equal,
    //                           toItem: contentView, attribute: .top,
    //                           multiplier: 1.0, constant: 0.0),
    //        NSLayoutConstraint(item: imageView, attribute: .width,
    //                           relatedBy: .equal,
    //                           toItem: scrollView, attribute: .width,
    //                           multiplier: 1.0, constant: 0.0),
    //        NSLayoutConstraint(item: imageView, attribute: .height,
    //                           relatedBy: .equal,
    //                           toItem: scrollView, attribute: .height,
    //                           multiplier: 1.0, constant: 0.0)
    //        ])
    //      if imageView == imageViews.first {
    //        NSLayoutConstraint.activate([
    //          NSLayoutConstraint(item: imageView, attribute: .left,
    //                             relatedBy: .equal,
    //                             toItem: contentView, attribute: .left,
    //                             multiplier: 1.0, constant: 0.0)
    //          ])
    //      } else {
    //        NSLayoutConstraint.activate([
    //          NSLayoutConstraint(item: imageView, attribute: .left,
    //                             relatedBy: .equal,
    //                             toItem: imageViews[i-1], attribute: .right,
    //                             multiplier: 1.0, constant: 0.0)
    //          ])
    //      }
    //
    //      if imageView == imageViews.last {
    //        NSLayoutConstraint.activate([
    //          NSLayoutConstraint(item: imageView, attribute: .right,
    //                             relatedBy: .equal,
    //                             toItem: contentView, attribute: .right,
    //                             multiplier: 1.0, constant: 0.0)
    //          ])
    //      }
    //    }
  }
  func setupIndicatorConstraints() {

    indicatorsView.bottomToSuperview(offset: -8.0)
    indicatorsView.centerXToSuperview()
    indicatorsView.height(8.0)
    indicatorsView.width(14.0 * 5.0)
    
//    NSLayoutConstraint.activate([
//
//      NSLayoutConstraint(item: leftTapView, attribute: .width,
//                         relatedBy: .equal,
//                         toItem: indicatorsView, attribute: .width,
//                         multiplier: 1.0, constant: 0.0),
//      NSLayoutConstraint(item: leftTapView, attribute: .right,
//                         relatedBy: .equal,
//                         toItem: indicatorsView, attribute: .centerX,
//                         multiplier: 1.0, constant: 0.0),
//      NSLayoutConstraint(item: leftTapView, attribute: .top,
//                         relatedBy: .equal,
//                         toItem: indicatorsView, attribute: .top,
//                         multiplier: 1.0, constant: 0.0),
//      NSLayoutConstraint(item: leftTapView, attribute: .bottom,
//                         relatedBy: .equal,
//                         toItem: self, attribute: .bottom,
//                         multiplier: 1.0, constant: 0.0),
//
//      NSLayoutConstraint(item: rightTapView, attribute: .width,
//                         relatedBy: .equal,
//                         toItem: indicatorsView, attribute: .width,
//                         multiplier: 1.0, constant: 0.0),
//      NSLayoutConstraint(item: rightTapView, attribute: .left,
//                         relatedBy: .equal,
//                         toItem: indicatorsView, attribute: .centerX,
//                         multiplier: 1.0, constant: 0.0),
//      NSLayoutConstraint(item: rightTapView, attribute: .top,
//                         relatedBy: .equal,
//                         toItem: indicatorsView, attribute: .top,
//                         multiplier: 1.0, constant: 0.0),
//      NSLayoutConstraint(item: rightTapView, attribute: .bottom,
//                         relatedBy: .equal,
//                         toItem: self, attribute: .bottom,
//                         multiplier: 1.0, constant: 0.0),
//      ])
  }
}

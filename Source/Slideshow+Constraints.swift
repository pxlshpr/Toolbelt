extension Slideshow {
  
  func addImagesCollectionView() {
    addSubview(imagesCollectionView)
    imagesCollectionView.edges(to: self)
  }
  
  func addIndicatorsCollectionView() {
    addSubview(indicatorsView)
    addSubview(tapViewContainer)

    indicatorsView.bottomToSuperview(offset: -8.0)
    indicatorsView.centerXToSuperview()
    indicatorsView.height(8.0)
    indicatorsView.width(14.0 * 5.0)
    
    tapViewContainer.widthToSuperview(multiplier: 0.5)
    tapViewContainer.height(16.0)
    tapViewContainer.bottomToSuperview()
    tapViewContainer.centerXToSuperview()
    
    leftTapView.leftToSuperview()
    rightTapView.rightToSuperview()

    for tapView in [leftTapView, rightTapView] {
      tapView.widthToSuperview(multiplier: 0.5)
      tapView.topToSuperview()
      tapView.bottomToSuperview()
    }
  }
}

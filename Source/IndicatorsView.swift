import UIKit

class IndicatorsView: UICollectionView {
  
  var numberOfIndicators: Int = 0
  var selectedIndicatorIndex: Int = 0 {
    didSet {
      updateOffsetBasedOnSelectedIndicator()
    }
  }

  convenience init() {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = .zero
    layout.itemSize = CGSize(width: 14.0, height: 14.0)
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0.0
    layout.minimumInteritemSpacing = 0.0
    
    self.init(frame: .zero, collectionViewLayout: layout)
    self.dataSource = self
    self.isPagingEnabled = true
    self.register(IndicatorCell.self,
                            forCellWithReuseIdentifier: String(describing: IndicatorCell.self))
    self.showsHorizontalScrollIndicator = false
    self.backgroundColor = .clear
  }
}

extension IndicatorsView: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.numberOfIndicators
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
      String(describing: IndicatorCell.self), for: indexPath)
    guard let indicatorCell = cell as? IndicatorCell else { return cell }
    indicatorCell.type = typeForIndicatorAt(indexPath)
    return indicatorCell
  }
}

extension IndicatorsView {
  
  func convertXValueToIndex(_ value: CGFloat) -> Int {
    return Int(value) / 14
  }
  
  func leftXValueForCellIndex(_ index: Int) -> CGFloat {
    return CGFloat(index * 14)
  }
  
  var firstVisibleCellIndex: Int {
    return convertXValueToIndex(contentOffset.x)
  }
  
  var lastVisibleCellIndex: Int {
    return convertXValueToIndex((contentOffset.x + frame.width) - 1.0)
  }
  
  var numberOfPossibleCells: Int {
    return Int(frame.width) / 14
  }
  
  func updateOffsetBasedOnSelectedIndicator() {
    //if index is (now going to be) the last *visible* cell, set the contentOffset so that the right end would be index+1 or endIndex, whichever is less
    if selectedIndicatorIndex >= lastVisibleCellIndex {
      let endIndex = min(selectedIndicatorIndex+1, numberOfIndicators-1)
      let startIndex = endIndex - numberOfPossibleCells + 1
      let offset = CGPoint(x: leftXValueForCellIndex(startIndex), y: 0)
      self.setContentOffset(offset, animated: true)
    }
    
    //if index is (now going to be) the first *visible* cell, set the contentOffset to have the first cell on the left be 0 or index-1, whichever is more
    if selectedIndicatorIndex <= firstVisibleCellIndex {
      let startIndex = max(0, selectedIndicatorIndex-1)
      let offset = CGPoint(x: leftXValueForCellIndex(startIndex), y: 0)
      self.setContentOffset(offset, animated: true)
    }
  }
  
  func typeForIndicatorAt(_ indexPath: IndexPath) -> IndicatorType {
    if indexPath.row == self.selectedIndicatorIndex {
      return .selected
    } else if indexPath.row == 0 || indexPath.row == self.numberOfIndicators - 1 {
      return .end
    } else {
      return .normal
    }
  }
}

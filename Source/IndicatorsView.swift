import UIKit

public class IndicatorsView: UICollectionView {
  
  var numberOfIndicators: Int = 0
  var selectedIndicatorIndex: Int = 0
  
  convenience init() {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = .zero
    layout.itemSize = CGSize(width: 14.0, height: 14.0)
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0.0
    layout.minimumInteritemSpacing = 0.0
    
    self.init(frame: .zero, collectionViewLayout: layout)
    self.dataSource = self
    self.delegate = self
    self.isPagingEnabled = true
    self.register(IndicatorCell.self,
                            forCellWithReuseIdentifier: String(describing: IndicatorCell.self))
    self.showsHorizontalScrollIndicator = false
    self.backgroundColor = .clear
    
    self.isUserInteractionEnabled = false
  }
}

extension IndicatorsView: UICollectionViewDelegate {
  
}

extension IndicatorsView: UIScrollViewDelegate {
  
  public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    self.reloadData()
  }
  
  public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    self.reloadData()
  }
}

extension IndicatorsView: UICollectionViewDataSource {
  
  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.numberOfIndicators
  }
  
  public func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
      String(describing: IndicatorCell.self), for: indexPath)
    guard let indicatorCell = cell as? IndicatorCell else { return cell }
    let type = typeForIndicatorAtRow(indexPath.row)
    indicatorCell.type = type
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
    let offset = contentOffset.x
    let index = convertXValueToIndex(offset)
    print("offset is \(offset), so offset is \(index)")
    return index
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
      let startIndex = endIndex - numberOfPossibleCells+1
      let offset = CGPoint(x: leftXValueForCellIndex(startIndex), y: 0)
      if offset != contentOffset {
        self.setContentOffset(offset, animated: true)
      }
    }
    
    //if index is (now going to be) the first *visible* cell, set the contentOffset to have the first cell on the left be 0 or index-1, whichever is more
    if selectedIndicatorIndex <= firstVisibleCellIndex {
      let startIndex = max(0, selectedIndicatorIndex-1)
      let offset = CGPoint(x: leftXValueForCellIndex(startIndex), y: 0)
      if offset != contentOffset {
        self.setContentOffset(offset, animated: true)
      }
    }
  }
  
  func typeForIndicatorAtRow(_ row: Int) -> IndicatorType {
    let firstIndex = firstVisibleCellIndex
    let lastIndex = lastVisibleCellIndex
    let selectedRow = self.selectedIndicatorIndex

    if row == selectedRow {
      return .selected
    } else if row == 0 && firstIndex == 0 {
      return .normal
    } else if row == numberOfIndicators-1 && lastIndex == numberOfIndicators-1 {
      return .normal
    } else if row <= firstIndex {
      return .small
    } else if row >= lastIndex {
      return .small
    } else {
      return .normal
    }
  }
}

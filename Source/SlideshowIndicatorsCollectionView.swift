import UIKit

public class SlideshowIndicatorsCollectionView: UICollectionView {
  
  enum K {
    static let indicatorSize: CGFloat = 14.0
  }
  var selectedIndicatorIndex: Int = 0
  var numberOfIndicators: Int = 0

  convenience init() {
    self.init(frame: .zero, collectionViewLayout: type(of: self).collectionViewLayout())
    self.backgroundColor = .clear
    self.dataSource = self
    self.delegate = self
    self.isPagingEnabled = true
    self.isUserInteractionEnabled = false
    self.showsHorizontalScrollIndicator = false
    self.register(SlideshowIndicatorCollectionViewCell.self, forCellWithReuseIdentifier:
      String(describing: SlideshowIndicatorCollectionViewCell.self))
  }
  
  func setupWithNumberOfIndicators(_ numberOfIndicators: Int) {
    self.numberOfIndicators = numberOfIndicators
    self.selectedIndicatorIndex = 0
    self.reloadData()
  }
  
  func scrollToIndex(_ index: Int) {
    selectedIndicatorIndex = index
    changeContentOffsetIfNeeded()
    reloadData()
  }
  
  func prepareForReuse() {
    numberOfIndicators = 0
    selectedIndicatorIndex = 0
    reloadData()
  }
  
  private func changeContentOffsetIfNeeded() {
    if selectedIndicatorIndex >= lastVisibleCellIndex {
      let neededEndIndex = min(selectedIndicatorIndex+1, numberOfIndicators-1)
      let startIndex = neededEndIndex - numberOfPossibleCells+1
      changeContentOffsetToIndex(startIndex)
    }
    
    if selectedIndicatorIndex <= firstVisibleCellIndex {
      let startIndex = max(0, selectedIndicatorIndex-1)
      changeContentOffsetToIndex(startIndex)
    }
  }
}

extension SlideshowIndicatorsCollectionView: UIScrollViewDelegate {
  
  public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    self.reloadData()
  }
  
  public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    self.reloadData()
  }
}

extension SlideshowIndicatorsCollectionView: UICollectionViewDataSource {
  
  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.numberOfIndicators
  }
  
  public func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
      String(describing: SlideshowIndicatorCollectionViewCell.self), for: indexPath)
    guard let indicatorCell = cell as? SlideshowIndicatorCollectionViewCell else { return cell }

    let type = typeForIndicatorAtRow(indexPath.row)
    indicatorCell.type = type
    return indicatorCell
  }
}

extension SlideshowIndicatorsCollectionView: UICollectionViewDelegate {
  
}

extension SlideshowIndicatorsCollectionView {

  fileprivate static func collectionViewLayout() -> UICollectionViewFlowLayout {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = .zero
    layout.itemSize = CGSize(width: K.indicatorSize, height: K.indicatorSize)
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0.0
    layout.minimumInteritemSpacing = 0.0
    return layout
  }
  
  fileprivate func typeForIndicatorAtRow(_ row: Int) -> SlideshowIndicatorType {
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

  fileprivate func changeContentOffsetToIndex(_ index: Int) {
    let offset = CGPoint(x: leftXValueForCellIndex(index), y: 0)
    if offset != contentOffset {
      self.setContentOffset(offset, animated: true)
    }
  }

  fileprivate func convertXValueToIndex(_ value: CGFloat) -> Int {
    return Int(value / K.indicatorSize)
  }

  fileprivate func leftXValueForCellIndex(_ index: Int) -> CGFloat {
    return CGFloat(index) * K.indicatorSize
  }

  fileprivate var firstVisibleCellIndex: Int {
    let offset = contentOffset.x
    let index = convertXValueToIndex(offset)
    return index
  }

  fileprivate var lastVisibleCellIndex: Int {
    return convertXValueToIndex((contentOffset.x + frame.width) - 1.0)
  }

  fileprivate var numberOfPossibleCells: Int {
    return Int(frame.width / K.indicatorSize)
  }
}

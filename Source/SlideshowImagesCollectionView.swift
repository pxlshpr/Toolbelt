import UIKit
import Nuke

public class SlideshowImagesCollectionView: UICollectionView {
  
  var selectedImageIndex: Int = 0
  var imageURLs: [URL] = []
  let preheater = Nuke.Preheater()
  var applyGradientToViews: Bool = false

  convenience init() {
    self.init(frame: .zero, collectionViewLayout: type(of: self).collectionViewLayout())
    self.backgroundColor = .clear
    self.dataSource = self
    self.isPagingEnabled = true
    self.showsHorizontalScrollIndicator = false
    self.register(SlideshowImageCollectionViewCell.self, forCellWithReuseIdentifier:
      String(describing: SlideshowImageCollectionViewCell.self))
  }
  
  func setupWithURLs(_ urls: [URL]) {
    log.verbose("Setting up with \(urls.count) urls")
    imageURLs = urls
    reloadData()
    preheater.startPreheating(with: urls.map { Nuke.Request.init(url: $0) })
  }
  
  func prepareForReuse() {
    log.verbose("Preparing for reuse")
    imageURLs = []
    reloadData()
    preheater.stopPreheating()
  }
}

extension SlideshowImagesCollectionView: UICollectionViewDataSource {
  
  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageURLs.count
  }
  
  public func collectionView(_ collectionView: UICollectionView,
                             cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
      String(describing: SlideshowImageCollectionViewCell.self), for: indexPath)
    guard let imageCell = cell as? SlideshowImageCollectionViewCell,
      imageURLs.count > indexPath.row else { return cell }
    
    //setup cell
    imageCell.setupWithImageURL(imageURLs[indexPath.row])
    imageCell.applyGradient = applyGradientToViews

    return imageCell
  }
}

extension SlideshowImagesCollectionView: UICollectionViewDelegate {
  
}

extension SlideshowImagesCollectionView {
  
  fileprivate static func collectionViewLayout(withWidth width: CGFloat = 0.0, height: CGFloat = 0.0)
    -> UICollectionViewFlowLayout {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = .zero
    layout.itemSize = CGSize(width: width, height: height)
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0.0
    layout.minimumInteritemSpacing = 0.0
    return layout
  }
}

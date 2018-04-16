import UIKit

extension Slideshow {

  // MARK: - Public

  public func startScrolling() {
    shouldScrollAutomatically = true
    startTimer()
  }
  
  public func stopScrolling() {
    shouldScrollAutomatically = false
    stopTimer()
  }

  public func scrollToIndex(_ index: Int) {
    selectedImageIndex = index
    imagesCollectionView.setContentOffset(offsetForIndex(selectedImageIndex), animated: true)
    delegate?.didChangeSelectedImageIndex(to: selectedImageIndex, onSlideshow: self)
    indicatorsView.scrollToIndex(selectedImageIndex)
  }

  // MARK: - Private
  func restartScrolling() {
    timer = Timer(timeInterval: 3.8, target: self,
                  selector: #selector(restartTimerFired(timer:)),
                  userInfo: nil, repeats: false)
    guard let timer = timer else { return }
    RunLoop.main.add(timer, forMode: .defaultRunLoopMode)
  }
  
  func startTimer() {
    timer = Timer(timeInterval: 4.8, target: self,
                  selector: #selector(timerFired(timer:)),
                  userInfo: nil, repeats: true)
    guard let timer = timer else { return }
    RunLoop.main.add(timer, forMode: .defaultRunLoopMode)
  }
  
  func stopTimer() {
    timer?.invalidate()
    timer = nil
  }
  
  func offsetForIndex(_ index: Int) -> CGPoint {
    return CGPoint(x: CGFloat(index) * frame.width, y: 0)
  }
}


@objc extension Slideshow {

  func restartTimerFired(timer: Timer) {
    startTimer()
  }

  func timerFired(timer: Timer) {
    if selectedImageIndex == numberOfImages - 1 {
      scrollToIndex(0)
    } else {
      scrollToIndex(selectedImageIndex + 1)
    }
  }
}

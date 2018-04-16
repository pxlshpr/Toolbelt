public protocol SlideshowDelegate: class {
  func didTapSlideshow(slideshow: Slideshow)
  func didChangeSelectedImageIndex(to index: Int, onSlideshow slideshow: Slideshow)
}

import UIKit

public extension UIColor {
  
  /**
   Initializes and returns a color object using the provided string representation of a hexadecimal number.
   
   - parameters:
   - hexString: The hexadecimal number of the color, represented as a string. It may be optionally prepended with the '#' symbol.
   
   - returns:
   The color object for the provided hexadecimal, if valid. If an invalid hexadecimal number is provided, UIColor.black is returned.
   */
  
  public convenience init?(hexString: String) {
    let hex = hexString.trimmingCharacters(in: CharacterSet(charactersIn: "#")).uppercased()
    guard hex.isValidHexadecimal else {
      return nil
    }
    
    var int = UInt32()
    Scanner(string: hex).scanHexInt32(&int)
    let a, r, g, b: UInt32
    switch hex.characters.count {
    case 3: // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (255, 0, 0, 0)
    }
    self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
  }
}

//MARK: Color Visibility

/**
 The following extension has been dervied from 
 https://www.w3.org/WAI/ER/WD-AERT/#color-contrast, 
 which was initially discovered in 
 http://stackoverflow.com/a/29044899
 */
public extension UIColor {
  
  struct K {
    static let BrightnessThreshold = 0.5 // commentor suggested trying 0.7
    static let MultiplierR = 299.0
    static let MultiplierG = 587.0
    static let MultiplierB = 114.0
  }

  public var brightness: Double? {
    guard let components = self.cgColor.components else {
      return nil
    }
    
    let componentColorR = Double(components[0]) * K.MultiplierR
    let componentColorG = Double(components[1]) * K.MultiplierG
    let componentColorB = Double(components[2]) * K.MultiplierB
    
    return (componentColorR + componentColorG + componentColorB)/1000.0
  }

  public func hasGoodVisibility(withColor color: UIColor) -> Bool {
    //W3: Two colors provide good color visibility if the brightness difference *AND* the color difference between the two colors are greater than a set range.
    return false
  }
  
  func colorDifference(withColor color: UIColor) -> Double? {
    /*
     Color difference is determined by the following formula:
     (maximum (Red value 1, Red value 2) - minimum (Red value 1, Red value 2)) + (maximum (Green value 1, Green value 2) - minimum (Green value 1, Green value 2)) + (maximum (Blue value 1, Blue value 2) - minimum (Blue value 1, Blue value 2))
     */
    return nil
  }
  
  func brightnessDifference(withColor color: UIColor) -> Double? {
    return nil
  }
  
  public var isLight: Bool {
    guard let brightness = brightness else {
      return false
    }
    
    return brightness >= K.BrightnessThreshold
  }
  
  public var barStyle: UIBarStyle {
    return isLight ? .default : .black
  }
}

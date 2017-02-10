import UIKit

public extension UIColor {
  
  /**
   A boolean value indicating whether this UIColor is light (implying that you would need black, instead of white font, to be visible over it).
    
    modified from: http://stackoverflow.com/a/29044899
    which is originally derived from: https://www.w3.org/WAI/ER/WD-AERT/#color-contrast
    */
  public var isLight: Bool {
    guard let components = self.cgColor.components else {
      return false
    }
    
    let componentColorR: CGFloat = components[0] * 299
    let componentColorG: CGFloat = components[1] * 587
    let componentColorB: CGFloat = components[2] * 114
    
    let brightness = componentColorR + componentColorG + componentColorB
    return brightness >= 500 //try up to 700 too (tests should reveal this!)
  }
  
  /**
   A UIBarStyle value that would be appropriate if this UIColor was used as the background for a UINavigationBar.
    */
  public var barStyle: UIBarStyle {
    return isLight ? .default : .black
  }
  
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

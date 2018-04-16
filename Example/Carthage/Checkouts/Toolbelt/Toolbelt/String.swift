
public extension String {
  /**
   A string value that returns the first word of this string, as separated by whitespace. Any leading whitespaces or newlines are ignored.
   */
  public var firstWord: String? {
    return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).components(separatedBy: " ").first
  }
  
  /**
   A Boolean value indicating whether a string only contains hexadecimal characters.
   */
  public var isValidHexadecimal: Bool {
    let chars = CharacterSet(charactersIn: "0123456789ABCDEF").inverted
    guard self.characters.count != 0, self.rangeOfCharacter(from: chars, options: .caseInsensitive, range: nil) == nil else {
      return false
    }
    return true
  }
}

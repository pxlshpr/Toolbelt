public extension String {

    /**
     A string value that returns the first word of this string, if any. Any leading whitespaces or newlines are ignored.
     */
    public var firstWord: String? {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).components(separatedBy: " ").first
    }
    
    /**
     A Boolean value indicating whether a string only contains hexadecimal characters.
     */
    public var isValidHexadecimal: Bool {
        let chars = CharacterSet(charactersIn: "0123456789ABCDEF").inverted
        guard self.rangeOfCharacter(from: chars, options: .caseInsensitive, range: nil) == nil else {
            return false
        }
        return true
    }
}

public extension Date {
    public var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}

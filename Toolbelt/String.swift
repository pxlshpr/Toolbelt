public extension String {

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

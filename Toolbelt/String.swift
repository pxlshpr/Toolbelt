import Foundation

extension String {
    
    func isValidHexNumber() -> Bool {
        let chars = CharacterSet(charactersIn: "0123456789ABCDEF").inverted
        guard self.rangeOfCharacter(from: chars, options: .caseInsensitive, range: nil) == nil else {
            return false
        }
        return true
    }

}

public extension String {

    public var firstWord: String? {
        return self.components(separatedBy: " ").first
    }
    
    
    //TODO: Maybe make this a variable instead? So change wherever it's used. Also get back that bash function 'ft' or whatever that finds the text you're looking for in the directory you're in and all its files/subdirectories
     //TODO: write documentation for these functions, and all others in Toolbelt. Have a workflow in mind for doing it regularly
     //TODO: Convert all code in all project's to two spaces being a tab (as per what Chris Lattner said)
     //TODO: Write tests *after* checking out what the code coverage badge is like without any for what we just added
     //TODO: Don't forget to replace the code we brough in (firstWord and the Date extension) with the framework in other projects 
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
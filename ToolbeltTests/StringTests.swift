import XCTest
@testable import Toolbelt

class ToolbeltTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIsValidHexadecimal() {
        
        let valid1 = "ABF0C5"
        let valid2 = "FFF"
        let valid3 = "AF00000F000"
        
        let invalid1 = "ASMX@S"
        let invalid2 = "GGG"
        let invalid3 = "^$&@#(&@#"
        
        XCTAssertTrue(valid1.isValidHexadecimal)
        XCTAssertTrue(valid2.isValidHexadecimal)
        XCTAssertTrue(valid3.isValidHexadecimal)

        XCTAssertFalse(invalid1.isValidHexadecimal)
        XCTAssertFalse(invalid2.isValidHexadecimal)
        XCTAssertFalse(invalid3.isValidHexadecimal)
    }
    
    func testFirstWord() {
    
        let returnsItself1 = "Word"
        let returnsItself2 = "Word."
        let returnsItself3 = "Word$@%^"
        let returnsItself4 = "words-separated-by-hyphens"
        for word in [returnsItself1, returnsItself2, returnsItself3, returnsItself4] {
            XCTAssertEqual(word.firstWord, word)
        }

        let returnsWord1 = "Word is a normal word."
        let returnsWord2 = "Word "
        let returnsWord3 = " Word"        
        let returnsWord4 = " Word "
        let returnsWord5 = " Word is a normal word."
        let returnsWord6 = "Word. This is a sentence."
        let returnsWord7 = " Word. This is a sentence."
        for word in [returnsWord1, returnsWord2, returnsWord3, returnsWord4, returnsWord5, returnsWord6, returnsWord7] {
            XCTAssertEqual(word.firstWord, "Word")
        }         
        
        let numbersWord = "98675 is also a word."
        XCTAssertEqual(numbersWord.firstWord, "98675")
        
        let symbolsWord = "^&%#@ could be a word, too."
        XCTAssertEqual(symbolsWord.firstWord, "^&%#@")
        
        let emojiiWord = "😈💀👻👽👾 is definitely a word."
        XCTAssertEqual(emojiiWord.firstWord, "😈💀👻👽👾")
        
        let bulletPoint = "- This is a bullet point."
        XCTAssertEqual(bulletPoint.firstWord, "-")
    }
}

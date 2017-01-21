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
    
    func testStartOfDay() {
    
    	let date = Date()
    	let calendar = Calendar.current
    	let hour = calendar.component(.hour, from: date)
    	let minutes = calendar.component(.minute, from: date)
    	let seconds = calendar.component(.second, from: date)
    	XCTAssertEqual(hour, 0)
    	XCTAssertEqual(minutes, 0)
    	XCTAssertEqual(seconds, 0)
    	
    	//TODO: test custome dates too and also check day month year
    }
    
    func testFirstWord() {
    
        let returnsItself1 = "Word"
        let returnsItself2 = "Word."
        let returnsItself3 = "Word$@%^"
        let returnsItself4 = "words-separated-by-hyphens"
        for sentence in [returnsItself1, returnsItself2, returnsItself3, returnsItself4] {
            XCTAssertEqual(sentence.firstWord, sentence)
        }

        let returnsWord1 = "Word is a normal word."
        let returnsWord2 = "Word "
        let returnsWord3 = " Word"        
        let returnsWord4 = " Word "
        let returnsWord5 = " Word is a normal word."
        let returnsWord6 = "\nWord"
        let returnsWord7 = "  \n\t\t Word"
        for sentence in [returnsWord1, returnsWord2, returnsWord3, returnsWord4, returnsWord5, returnsWord6, returnsWord7] {
            XCTAssertEqual(sentence.firstWord, "Word")
        }         

        let returnsWordAndPeriod1 = "Word. This is a sentence."
        let returnsWordAndPeriod2 = " Word. This is a sentence."
        for sentence in [returnsWordAndPeriod1, returnsWordAndPeriod2] {
            XCTAssertEqual(sentence.firstWord, "Word.")
        }
        
        
        let numbersWord = "98675 is also a word."
        XCTAssertEqual(numbersWord.firstWord, "98675")
        
        let symbolsWord = "^&%#@ could be a word, too."
        XCTAssertEqual(symbolsWord.firstWord, "^&%#@")
        
        let emojiiWord = "😈💀👻👽👾 is definitely a word."
        XCTAssertEqual(emojiiWord.firstWord, "😈💀👻👽👾")
        
        let bulletPoint = "- This is a bullet point."
        XCTAssertEqual(bulletPoint.firstWord, "-")
        
        let emptySentence = ""
        let whitespace = "    "
        let whitespaceNewLinesAndTabs = "  \t\n\n\t\t    \t\t   \n\n"
        for sentence in [emptySentence, whitespace, whitespaceNewLinesAndTabs] {
          XCTAssertEqual(sentence.firstWord, "")
        }
    }
}

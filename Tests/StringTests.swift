import XCTest
@testable import Toolbelt

class StringTests: XCTestCase {
  
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
    for valid in [valid1, valid2, valid3] {
      XCTAssertTrue(valid.isValidHexadecimal, "Failed to identify valid hexadecimal")
    }
    
    let invalid1 = "ASMX@S"
    let invalid2 = "GGG"
    let invalid3 = "^$&@#(&@#"
    let invalid4 = ""
    let invalid5 = "#FFF"
    let invalid6 = "#FFFFFF"
    for invalid in [invalid1, invalid2, invalid3, invalid4, invalid5, invalid6] {
      XCTAssertFalse(invalid.isValidHexadecimal, "Failed to identify invalid hexadecimal")
    }
  }
  
  func testFirstWord() {
    
    let returnsItself1 = "Word"
    let returnsItself2 = "Word."
    let returnsItself3 = "Word$@%^"
    let returnsItself4 = "words-separated-by-hyphens"
    for sentence in [returnsItself1, returnsItself2, returnsItself3, returnsItself4] {
      XCTAssertEqual(sentence.firstWord, sentence, "Failed to get first word correctly")
    }
    
    let returnsWord1 = "Word is a normal word."
    let returnsWord2 = "Word "
    let returnsWord3 = " Word"
    let returnsWord4 = " Word "
    let returnsWord5 = " Word is a normal word."
    let returnsWord6 = "\nWord"
    let returnsWord7 = "  \n\t\t Word"
    for sentence in [returnsWord1, returnsWord2, returnsWord3, returnsWord4, returnsWord5, returnsWord6, returnsWord7] {
      XCTAssertEqual(sentence.firstWord, "Word", "Failed to get first word correctly")
    }
    
    let returnsWordAndPeriod1 = "Word. This is a sentence."
    let returnsWordAndPeriod2 = " Word. This is a sentence."
    for sentence in [returnsWordAndPeriod1, returnsWordAndPeriod2] {
      XCTAssertEqual(sentence.firstWord, "Word.", "Failed to get first word correctly")
    }
    
    
    let numbersWord = "98675 is also a word."
    XCTAssertEqual(numbersWord.firstWord, "98675", "Failed to get first word correctly")
    
    let symbolsWord = "^&%#@ could be a word, too."
    XCTAssertEqual(symbolsWord.firstWord, "^&%#@", "Failed to get first word correctly")
    
    let emojiiWord = "😈💀👻👽👾 is definitely a word."
    XCTAssertEqual(emojiiWord.firstWord, "😈💀👻👽👾", "Failed to get first word correctly")
    
    let bulletPoint = "- This is a bullet point."
    XCTAssertEqual(bulletPoint.firstWord, "-", "Failed to get first word correctly")
    
    let emptySentence = ""
    let whitespace = "    "
    let whitespaceNewLinesAndTabs = "  \t\n\n\t\t    \t\t   \n\n"
    for sentence in [emptySentence, whitespace, whitespaceNewLinesAndTabs] {
      XCTAssertEqual(sentence.firstWord, "", "Failed to get first word correctly")
    }
  }
}

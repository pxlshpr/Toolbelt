import Foundation

//MARK: - NIH
//source: http://stackoverflow.com/questions/29588158/check-if-all-elements-of-an-array-have-the-same-value-in-swift
//TODO: move this to its own file
public extension Array where Element : Equatable {
  public var containsDuplicates: Bool {
    if let firstElement = first {
      return !dropFirst().contains { $0 != firstElement }
    }
    return true
  }
}
//MARK: ***

//MARK: - NIH (Modified)
//source: http://stackoverflow.com/questions/34712453/random-number-x-amount-till-x-amount-swift/34712601#34712601
//TODO: rename doIt
func doIt(lower: Int, upper: Int) -> Int {
    var delta = upper - lower
    delta = Swift.min(delta, Int(UInt32.max))
    
    let random = Int(arc4random_uniform(UInt32(delta)))
    return lower + random
}

public extension CountableRange where Bound: Integer {
    public var random: Int {
        return doIt(lower: Int(lowerBound.toIntMax()), upper: Int(upperBound.toIntMax()))
    }
}

public extension CountableClosedRange where Bound: Integer {
    public var random: Int {
        let upper = Swift.min(Int(upperBound.toIntMax()), Int.max - 1)
        return doIt(lower: Int(lowerBound.toIntMax()), upper: upper + 1)
    }
}
//MARK: ***

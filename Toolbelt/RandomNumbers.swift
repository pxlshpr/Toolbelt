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
func randomNumber(between lower: Int, and upper: Int) -> Int {
  let delta = Int.subtractWithOverflow(upper, lower)
  let limit = delta.overflow ? UInt32.max : UInt32(Swift.min(delta.0, Int(UInt32.max)))
  let random = Int(arc4random_uniform(limit))
  return lower + random
}

public extension CountableRange where Bound: Integer {
    public var random: Int {
        return randomNumber(between: Int(lowerBound.toIntMax()), and: Int(upperBound.toIntMax()))
    }
}

public extension CountableClosedRange where Bound: Integer {
    public var random: Int {
        let upper = Swift.min(Int(upperBound.toIntMax()), Int.max - 1)
        return randomNumber(between: Int(lowerBound.toIntMax()), and: upper + 1)
    }
}
//MARK: ***

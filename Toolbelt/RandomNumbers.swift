import Foundation

//MARK: - NIH
//source: http://stackoverflow.com/questions/29588158/check-if-all-elements-of-an-array-have-the-same-value-in-swift
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
public extension CountableRange where Bound: Integer {
  public var random: Int {
    return Int(lowerBound.toIntMax()) + Int(arc4random_uniform(UInt32((upperBound - lowerBound).toIntMax())))
  }
}

public extension CountableClosedRange where Bound: Integer {
  public var random: Int {
    let lower = Int(lowerBound.toIntMax())
    
    //TODO: even though this makes things safer (by forbi
    var delta = Int(upperBound.toIntMax() - lowerBound.toIntMax())
    delta = Swift.min(delta, Int(UInt32.max - 2))
    
    let random = Int(arc4random_uniform(UInt32((delta + 1).toIntMax())))
    return lower + random
  }
}
//MARK: ***

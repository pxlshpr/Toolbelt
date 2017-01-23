import Foundation

public func randomIntegerInclusively(between min: Int, and max: Int) -> Int {
  if max < min { return min }
  return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
}

public func randomIntegerBetween0(and upperLimit: Int) -> Int {
  return Int(arc4random_uniform(UInt32(upperLimit)))
}

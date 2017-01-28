import Foundation

public func randomIntegerInclusively(between min: Int, and max: Int) -> Int {
  if max < min { return min }
  return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
}

//public func randomIntegerBetween0(and upperLimit: Int) -> Int {
//  return Int(arc4random_uniform(UInt32(upperLimit)))
//}

public func randomIntegerBetween0<T: Integer>(and upperLimit: T) -> T {
  
//  return Int(arc4random_uniform(UInt32(upperLimit)))
  
  // use something like this:
  //from: http://stackoverflow.com/questions/34712453/random-number-x-amount-till-x-amount-swift/34712601#34712601
  /*extension ClosedRange where Bound: Integer {
    var random: Int {
        return Int(lowerBound.toIntMax()) + Int(arc4random_uniform(UInt32((upperBound - lowerBound + 1).toIntMax())))
    }
}
extension CountableRange where Bound: Integer {
    var random: Int {
        return Int(lowerBound.toIntMax()) + Int(arc4random_uniform(UInt32((upperBound - lowerBound).toIntMax())))
    }
}


(10...20).random   // 16*/
  return 0
}

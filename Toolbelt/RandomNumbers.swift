import Foundation

//MARK: - NIH
//source: http://stackoverflow.com/questions/31391577/how-can-i-generate-large-ranged-random-numbers-in-swift
extension UInt {
  static func random(between first: UInt, and second: UInt) -> UInt {
    
    let minValue = first > second ? second : first
    let maxValue = first > second ? first : second
    
    if minValue == UInt.min && maxValue == UInt.max {
      // Random number in the full range of UInt:
      
      var rnd: UInt = 0
      arc4random_buf(&rnd, MemoryLayout.size(ofValue: rnd))
      return rnd
    } else {
      // Compute random number in the range 0 ... (maxValue-minValue),
      // using the technique from
      // http://stackoverflow.com/a/26550169/1187415, http://stackoverflow.com/a/10989061/1187415
      // and avoiding the "modulo bias problem":
      
      let range = maxValue - minValue + 1
      let randLimit = UInt.max - UInt.max % range
      var rnd: UInt = 0
      repeat {
        arc4random_buf(&rnd, MemoryLayout.size(ofValue: rnd))
      } while rnd >= randLimit
      rnd = rnd % range
      
      // Transform `rnd` back to the range minValue ... maxValue:
      return minValue + rnd
    }
  }
}

extension Int {
  static func random(between first: Int, and second: Int) -> Int {
    
    let minValue = first > second ? second : first
    let maxValue = first > second ? first : second
    
    // Compute unsigned random number in the range 0 ... (maxValue-minValue):
    let diff = UInt(bitPattern: maxValue &- minValue)
    let rnd = UInt.random(between: 0, and: diff)
    
    // Transform `rnd` back to the range minValue ... maxValue:
    return minValue &+ Int(bitPattern: rnd)
  }
}

extension Double {
  static func random(between first: Double, and second: Double) -> Double {
    
    //TODO can we modularize this?
    let minValue = first > second ? second : first
    let maxValue = first > second ? first : second
    
    // Random floating point number in the range 0.0 ... 1.0:
    let rnd = Double(UInt.random(between: 0, and: UInt.max))/Double(UInt.max)
    
    // Scale to range minValue ... maxValue:
    var delta = maxValue - minValue
    if delta == Double.infinity {
      delta = DBL_MAX
    }
    return minValue + rnd * delta
  }
}

extension Float {
  static func random(between first: Float, and second: Float) -> Float {
    
    //TODO can we modularize this?
    let minValue = first > second ? second : first
    let maxValue = first > second ? first : second
    
    // Random floating point number in the range 0.0 ... 1.0:
    let rnd = Float(UInt.random(between: 0, and: UInt.max))/Float(UInt.max)
    
    // Scale to range minValue ... maxValue:
    var delta = maxValue - minValue
    if delta == Float.infinity {
      delta = FLT_MAX
    }
    return minValue + rnd * delta
  }
}

//***

//MARK: - NIH (Modified)
//source: http://stackoverflow.com/questions/34712453/random-number-x-amount-till-x-amount-swift/34712601#34712601
public extension CountableRange where Bound: Integer {
  public var random: Int {
    return Int.random(between: Int(lowerBound.toIntMax()), and: Int(upperBound.toIntMax())-1)
  }
}

//Workaround for extending a Range of a specific type
//source: http://stackoverflow.com/questions/40580054/swift-3-extend-range-of-specific-type
public protocol _Int {}
extension Int: _Int {}

public extension CountableClosedRange where Bound: _Int {
  
  //TODO: Document that this always returns an Int, not a UInt
  //TODO: Document that this does wierd things with UInt range's specifically containing larger numbers that are greater than Int.max (as UInt.max > Int.max). So for something like (UInt.max-1...UInt.max).random we would get a value not within that range! This is inherently because we are returning an Int (and not a UInt), so the type isn't big enough to contain a number in that domain anyway. The alternative would be to return Any and then be checkd and casted whenever retrieving (as we're unable to constrain the extension to where Bound is an Int and not the protocol Integer).
  
  //TODO: Instead of all that ^^ – for completion's sake, we should have both
  // public var randomUInt
  //AND
  // public var randomInt
  //additionally, have
  // public var randomDouble
  //AND
  // public var randomFloat
  // based on what we want and what the inputs are
  // but still –
  // (UInt.max-1...UInt.max).randomInt would yield what??
  
  public var random: Int {
    let first: Int
    let second: Int
    if let lower = lowerBound as? UInt, let upper = upperBound as? UInt {
      first = Int(Swift.min(lower, UInt(Int.max - 1)))
      second = Int(Swift.min(upper, UInt(Int.max - 1)))
    } else {
      //TODO: are we correct in makin the assumption that this – has to be an Int (Int64 or smaller)
      //TODO: why do we return 0 here?
      first = Int(lowerBound.toIntMax())
      second = Swift.min(Int(upperBound.toIntMax()), Int.max - 1)
    }
    return Int.random(between: first, and: second)
  }
}

public extension Range where Bound: FloatingPoint {
  public var random: Double {
    if let lower = lowerBound as? Double, let upper = upperBound as? Double {
      return Double.random(between: lower, and: upper)
    } else {
      //TODO: why do we return 0 here?
      return 0
    }
  }
}

public extension ClosedRange where Bound: FloatingPoint {
  public var random: Double {
    
    if let lower = lowerBound as? Double, let upper = upperBound as?
      Double {
      let closedUpper = Swift.min(upper, Double(Int.max - 1))
      return Double.random(between: lower, and: closedUpper)
    } else {
      //TODO: why do we return 0 here?
      return 0
    }
  }
}

//MARK: ***

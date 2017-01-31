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

// MARK: - Range Extensions

//References:
//- http://stackoverflow.com/questions/34712453/random-number-x-amount-till-x-amount-swift/34712601#34712601
//- http://stackoverflow.com/questions/40580054/swift-3-extend-range-of-specific-type

public protocol _Int {}
extension Int: _Int {}

public protocol _UInt {}
extension UInt: _UInt {}

public extension CountableClosedRange where Bound: _Int {
  public var random: Int {
    return Int.random(between: lowerBound as! Int, and: upperBound as! Int)
  }
}

public extension CountableClosedRange where Bound: _UInt {
  public var random: UInt {
    return UInt.random(between: lowerBound as! UInt, and: upperBound as! UInt)
  }
}

public extension CountableRange where Bound: _UInt {
  public var random: UInt {
    let lower = lowerBound as! UInt
    var upper = upperBound as! UInt
    if lower != upper {
      upper = upper == UInt.min ? UInt.min : upper - 1
    }
    return UInt.random(between: lower, and: upper)
  }
}

public extension CountableRange where Bound: _Int {
  public var random: Int {
    let lower = lowerBound as! Int
    var upper = upperBound as! Int
    if lower != upper {
      upper = upper == Int.min ? Int.min : upper - 1
    }
    return Int.random(between: lower, and: upper)
  }
}

// MARK: Doubles

public protocol _Double {}
extension Double: _Double {}

public protocol _Float {}
extension Float: _Float {}

public extension ClosedRange where Bound: _Double {
  public var random: Double {
    return Double.random(between: lowerBound as! Double, and: upperBound as! Double)
  }
}

public extension ClosedRange where Bound: _Float {
  public var random: Float {
    return Float.random(between: lowerBound as! Float, and: upperBound as! Float)
  }
}

public extension Range where Bound: _Double {
  public var random: Double {
    let lower = lowerBound as! Double
    var upper = upperBound as! Double
    if lower != upper {
      upper = upper == -DBL_MAX ? -DBL_MAX : upper - DBL_MIN
    }
    return Double.random(between: lower, and: upper)
  }
}

public extension Range where Bound: _Float {
  public var random: Float {
    let lower = lowerBound as! Float
    var upper = upperBound as! Float
    if lower != upper {
      upper = upper == -FLT_MAX ? -FLT_MAX : upper - FLT_MIN
    }
    return Float.random(between: lower, and: upper)
  }
}

//MARK: ***

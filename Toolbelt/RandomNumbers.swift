import Foundation

//MARK: - NIH
//source: http://stackoverflow.com/questions/31391577/how-can-i-generate-large-ranged-random-numbers-in-swift
extension UInt {
  static func random(minValue: UInt, maxValue: UInt) -> UInt {
    precondition(minValue <= maxValue, "attempt to call random() with minValue > maxValue")
    
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
  static func random(minValue: Int, maxValue: Int) -> Int {
    precondition(minValue <= maxValue, "attempt to call random() with minValue > maxValue")
    
    // Compute unsigned random number in the range 0 ... (maxValue-minValue):
    let diff = UInt(bitPattern: maxValue &- minValue)
    let rnd = UInt.random(minValue: 0, maxValue: diff)
    
    // Transform `rnd` back to the range minValue ... maxValue:
    return minValue &+ Int(bitPattern: rnd)
  }
}

extension Double {
  static func random(minValue: Double, maxValue: Double) -> Double {
    precondition(minValue <= maxValue, "attempt to call random() with minValue > maxValue")
    
    // Random floating point number in the range 0.0 ... 1.0:
    let rnd = Double(UInt.random(minValue: 0, maxValue: UInt.max))/Double(UInt.max)
    
    // Scale to range minValue ... maxValue:
    return minValue + rnd * (maxValue - minValue)
  }
}
//***

//MARK: - NIH (Modified)
//source: http://stackoverflow.com/questions/34712453/random-number-x-amount-till-x-amount-swift/34712601#34712601
public extension CountableRange where Bound: Integer {
    public var random: Int {
        return Int.random(minValue: Int(lowerBound.toIntMax()), maxValue: Int(upperBound.toIntMax())-1)
    }
}

public extension CountableClosedRange where Bound: Integer {
    public var random: Int {
        let upper = Swift.min(Int(upperBound.toIntMax()), Int.max - 1)
        return Int.random(minValue: Int(lowerBound.toIntMax()), maxValue: upper)
    }
}

public extension Range where Bound: FloatingPoint {
  public var random: Double {
    if let lower = lowerBound as? Double, let upper = upperBound as? Double {
      return Double.random(minValue: lower, maxValue: upper)
    } else {
      return 0
    }
  }
}

public extension ClosedRange where Bound: FloatingPoint {
  public var random: Double {
    if let lower = lowerBound as? Double, let upper = upperBound as?
      Double {
      let closedUpper = Swift.min(upper, Double(Int.max - 1))
      return Double.random(minValue: lower, maxValue: closedUpper)
    } else {
      return 0
    }
  }
}

//MARK: ***

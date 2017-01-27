import UIKit

protocol NumericType {
    func +(lhs: Self, rhs: Self) -> Self
    func -(lhs: Self, rhs: Self) -> Self
    func *(lhs: Self, rhs: Self) -> Self
    func /(lhs: Self, rhs: Self) -> Self
    func %(lhs: Self, rhs: Self) -> Self
    init(_ v: Int)
}

extension Double : NumericType { }
extension Float  : NumericType { }
extension Int    : NumericType { }
extension Int8   : NumericType { }
extension Int16  : NumericType { }
extension Int32  : NumericType { }
extension Int64  : NumericType { }
extension UInt   : NumericType { }
extension UInt8  : NumericType { }
extension UInt16 : NumericType { }
extension UInt32 : NumericType { }
extension UInt64 : NumericType { }


//TODO: Look into supporting doubles by instead type/protocol constricting to Arithmetic or Strideable or something 
func randomIntegerBetween0<T: Integer>(and limit: T) -> T? {
    let limit32: UInt32
    switch type(of: limit) {
    case is Int.Type:
        limit32 = UInt32(limit as! Int)
    default:
        //should never get here, how do we make this exhaustive?
        limit32 = UInt32(0)
    }
    
    //cast as Int so that we can then cast is a T (Int works, but UInt32 doesn't – why?)
    let r = Int(arc4random_uniform(limit32))
    return r as? T
    //if let casted = r as? T {
    //return 4
    //} else {
    //return 0
    //}
}

randomIntegerBetween0(and: 30)
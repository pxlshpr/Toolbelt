/**
 Returns an iteratory that iterates through all cases of a provided enum.
 
 - Author:
 @rintaro on StackOverflow
 
 - returns:
 An iterator that iterates through all the cases of the provided enum.
 
 - parameters:
 - T: An enum
 
 Original discovered [here](http://stackoverflow.com/questions/24007461/how-to-enumerate-an-enum-with-string-type)
 */
public func enumIterator<T: Hashable>(_: T.Type) -> AnyIterator<T> {
  var i = 0
  return AnyIterator {
    let next = withUnsafePointer(to: &i) {
      $0.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee }
    }
    if next.hashValue != i { return nil }
    i += 1
    return next
  }
}

/**
 Returns the number of cases of the provided enum.
 
 - returns:
 The number of cases that the provided enum has.
 
 - parameters:
 - T: An enum
 */
public func numberOfCases<T: Hashable>(_: T.Type) -> Int {
  let iterator = enumIterator(T.self)
  return Array(iterator).count
}

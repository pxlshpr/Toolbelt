public extension Date {
  
  /**
   This property returns the first moment of this Date, as a Date.
   */
  public var startOfDay: Date {
    return Calendar.current.startOfDay(for: self)
  }
  
  /** This property returns the year component of this Date. */
  public var year: Int { return component(.year) }
  
  /** This property returns the month component of this Date. */
  public var month: Int { return component(.month) }
  
  /** This property returns the day component of this Date. */
  public var day: Int { return component(.day) }
  
  /** This property returns the hour component of this Date. */
  public var hour: Int { return component(.hour) }
  
  /** This property returns the minute component  of this Date. */
  public var minute: Int { return component(.minute) }
  
  /** This property returns the second component of this Date. */
  public var second: Int { return component(.second) }
  
  // MARK : - Functions
  
  /**
   Returns the specified component of this date, in the current calendar.
   
   - returns:
   The specified component of this date, in the current calendar.
   
   - parameters:
   - component: The calendar component to be returned.
   */
  public func component(_ component: Calendar.Component) -> Int {
    return Calendar.current.component(component, from: self)
  }
}

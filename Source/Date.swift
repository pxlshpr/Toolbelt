//TODO: move these to Sugar
public extension Date {
  
  /** Date object for 00:00 on this date. */
  public var startOfDay: Date { return Calendar.current.startOfDay(for: self) }
  
  /** The year of this date. */
  public var year: Int { return component(.year) }
  
  /** The month number of this date. */
  public var month: Int { return component(.month) }
  
  /** The day of this date. */
  public var day: Int { return component(.day) }
  
  /** The hour of this date. */
  public var hour: Int { return component(.hour) }

  /** The minute of this date. */
  public var minute: Int { return component(.minute) }
  
  /** The second of this date. */
  public var second: Int { return component(.second) }
}

private extension Date {
  /**
   Returns the specified component of this date, in the current calendar.
   
   - returns:
   The specified component of this date, in the current calendar.
   
   - parameters:
   - component: The calendar component to be returned.
   */
  private func component(_ component: Calendar.Component) -> Int {
    return Calendar.current.component(component, from: self)
  }
}

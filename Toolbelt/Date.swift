public extension Date {
    public var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}

//TODO: how do we test this? maybe test that every single enum was actually reached?
//http://stackoverflow.com/questions/24007461/how-to-enumerate-an-enum-with-string-type
public func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
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

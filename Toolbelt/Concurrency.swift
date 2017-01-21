import Foundation
/*
/// Asynchronously runs the given closure in the background
///
/// :param: closure the closure to run in the background
public func background(closure: () -> ()) {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), closure)
}

/// This method runs a closure in the background after a specified delay
///
/// :param: seconds the delay in seconds
/// :param: closure the closure to run
public func background(seconds: Double, closure: () -> ()) {
    delay(seconds, queue: dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), closure: closure)
}

/// This method delays running a closure on the current queue
///
/// :param: seconds delay, in seconds
/// :param: closure the closure to run
public func delay(seconds: Double, closure: () -> ()) {
    delay(seconds, queue: dispatch_get_global_queue(qos_class_self(), 0), closure: closure)
}

// MARK: - 🙈 Private

/// This method delays running a closure on the specified queue
///
/// :param: seconds delay, in seconds
/// :param: queue the queue to run the closure on
/// :param: closure the closure to run
private func delay(seconds: Double, queue: dispatch_queue_t, closure: () -> ()) {
    let when = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
    dispatch_after(when, queue, closure)
}
*/
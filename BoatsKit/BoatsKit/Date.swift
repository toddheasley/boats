//
// © 2018 @toddheasley
//

import Foundation

extension Date {
    public func day(timeZone: TimeZone? = nil) -> DateInterval {
        var calendar: Calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timeZone ?? .current
        return DateInterval(start: calendar.startOfDay(for: self), duration: 86400.0)
    }
}

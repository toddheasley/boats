import Foundation

extension Date {
    public func day(timeZone: TimeZone = .current) -> DateInterval {
        var calendar: Calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timeZone
        return DateInterval(start: calendar.startOfDay(for: self), duration: 86400.0)
    }
}

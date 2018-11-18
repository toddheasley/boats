import Foundation

extension DateFormatter {
    enum ClockFormat {
        case twelveHour, twentyFourHour, auto
    }
    
    static let shared: DateFormatter = DateFormatter(timeZone: .shared)
    static var clockFormat: ClockFormat = .auto
    
    var is24Hour: Bool {
        switch DateFormatter.clockFormat {
        case .twelveHour:
            return false
        case .twentyFourHour:
            return true
        case .auto:
            dateStyle = .none
            timeStyle = .medium
            return !string(from: Date()).contains(" ")
        }
    }
    
    func time(from date: Date) -> Time {
        dateFormat = "H:m"
        let components: [String] = string(from: date).components(separatedBy: ":")
        return Time(hour: Int(components[0])!, minute: Int(components[1])!)
    }
    
    func next(in components: [(year: Int, month: Int, day: Int)], from date: Date = Date()) -> Date {
        for component in components {
            let next: Date = calendar.date(from: DateComponents(timeZone: .shared, year: component.year, month: component.month, day: component.day))!
            if date > next {
                continue
            }
            return next
        }
        return Date(timeIntervalSince1970: 0.0)
    }
    
    func next(month: Int, day: Int, from date: Date = Date()) -> Date {
        let year: Int = self.year(from: date)
        let next: Date = calendar.date(from: DateComponents(timeZone: .shared, year: year, month: month, day: day))!
        if date > next {
            return calendar.date(from: DateComponents(timeZone: .shared, year: year + 1, month: month, day: day))!
        }
        return next
    }
    
    func year(from date: Date) -> Int {
        dateFormat = "y"
        return Int(string(from: date))!
    }
    
    convenience init(timeZone: TimeZone) {
        DateFormatter.calendar.timeZone = timeZone
        self.init()
        self.timeZone = timeZone
    }
    
    private static var calendar: Calendar = Calendar(identifier: .gregorian)
    
    private var calendar: Calendar {
        return DateFormatter.calendar
    }
}

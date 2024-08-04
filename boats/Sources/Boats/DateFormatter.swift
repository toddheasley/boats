import Foundation

extension DateFormatter {
    enum ClockFormat {
        case twelveHour, twentyFourHour, system
    }
    
    static let shared: DateFormatter = DateFormatter(timeZone: .shared)
    nonisolated(unsafe) static var clockFormat: ClockFormat = .system
    
    var is24Hour: Bool {
        switch Self.clockFormat {
        case .system:
            guard let format = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: .current) else {
                fallthrough // Default to shared timezone 12-hour format
            }
            return !format.contains("a")
        case .twelveHour:
            return false
        case .twentyFourHour:
            return true
        }
    }
    
    func accessibilityDescription(from dateInterval: DateInterval) -> String {
        let year: (start: Int, end: Int) = (self.year(from: dateInterval.start), self.year(from: dateInterval.end))
        dateFormat = "MMMM d"
        switch year.start {
        case year.end:
            return "\(string(from: dateInterval.start)) through \(string(from: dateInterval.end)), \(year.end)"
        default:
            return "\(string(from: dateInterval.start)), \(year.start) through \(string(from: dateInterval.end)), \(year.end)"
        }
    }
    
    func description(from dateInterval: DateInterval) -> String {
        let year: (start: Int, end: Int) = (self.year(from: dateInterval.start), self.year(from: dateInterval.end))
        dateFormat = "MMM d"
        switch year.start {
        case year.end:
            return "\(string(from: dateInterval.start))-\(string(from: dateInterval.end)), \(year.end)"
        default:
            return "\(string(from: dateInterval.start)), \(year.start)-\(string(from: dateInterval.end)), \(year.end)"
        }
    }
    
    func description(from date: Date) -> String {
        dateFormat = "MMM d"
        return string(from: date)
    }
    
    func time(from date: Date) -> Time {
        dateFormat = "H:m"
        let components: [String] = string(from: date).components(separatedBy: ":")
        return Time(hour: Int(components[0])!, minute: Int(components[1])!)
    }
    
    func next(in components: [(year: Int, month: Int, day: Int)], from date: Date = Date()) -> Date {
        for component in components {
            let next: Date = Self.calendar.date(from: DateComponents(timeZone: .shared, year: component.year, month: component.month, day: component.day))!
            if date > next {
                continue
            }
            return next
        }
        return Date(timeIntervalSince1970: 0.0)
    }
    
    func next(month: Int, day: Int, from date: Date = Date()) -> Date {
        let year: Int = self.year(from: date)
        let next: Date = Self.calendar.date(from: DateComponents(timeZone: .shared, year: year, month: month, day: day))!
        if date > next {
            return Self.calendar.date(from: DateComponents(timeZone: .shared, year: year + 1, month: month, day: day))!
        }
        return next
    }
    
    func date(near date: Date = Date(), html: String?) -> Date? {
        guard let html: String = html else {
            return nil
        }
        let dateInterval: DateInterval = DateInterval(start: Date(timeInterval: -15778800.0, since: date), duration: 31557600.0)
        dateFormat = "yyyy"
        let years: [String] = [string(from: dateInterval.start), string(from: dateInterval.end)]
        dateFormat = "M/d/yyyy"
        for year in years {
            guard let htmlDate: Date = self.date(from: "\(html)/\(year)"), dateInterval.contains(htmlDate) else {
                continue
            }
            return htmlDate
        }
        return nil
    }
    
    func day(from date: Date) -> Day {
        let date: Date = Self.calendar.startOfDay(for: date)
        dateFormat = "EEEE"
        return Day(rawValue: string(from: date).lowercased())!
    }
    
    func year(from date: Date) -> Int {
        dateFormat = "y"
        return Int(string(from: date))!
    }
    
    convenience init(timeZone: TimeZone) {
        Self.calendar.timeZone = timeZone
        self.init()
        self.timeZone = timeZone
    }
    
    nonisolated(unsafe) private static var calendar: Calendar = Calendar(identifier: .gregorian)
}

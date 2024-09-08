import Foundation

extension DateFormatter {
    enum ClockFormat {
        case twelveHour, twentyFourHour, system
    }
    
    nonisolated(unsafe) static var clockFormat: ClockFormat = .system
    
    static var is24Hour: Bool {
        switch clockFormat {
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
}

extension DateFormatter {
    static func accessibilityDescription(from dateInterval: DateInterval) -> String {
        let year: (start: Int, end: Int) = (year(from: dateInterval.start), year(from: dateInterval.end))
        switch year.start {
        case year.end:
            return "\(MMMMd.string(from: dateInterval.start)) through \(MMMMd.string(from: dateInterval.end)), \(year.end)"
        default:
            return "\(MMMMd.string(from: dateInterval.start)), \(year.start) through \(MMMMd.string(from: dateInterval.end)), \(year.end)"
        }
    }
    
    static func description(from dateInterval: DateInterval) -> String {
        let year: (start: Int, end: Int) = (year(from: dateInterval.start), year(from: dateInterval.end))
        switch year.start {
        case year.end:
            return "\(MMMd.string(from: dateInterval.start))-\(MMMd.string(from: dateInterval.end)), \(year.end)"
        default:
            return "\(MMMd.string(from: dateInterval.start)), \(year.start)-\(MMMd.string(from: dateInterval.end)), \(year.end)"
        }
    }
    
    static func description(from date: Date) -> String {
        MMMd.string(from: date)
    }
    
    static func time(from date: Date) -> Time {
        let components: [String] = Hm.string(from: date).components(separatedBy: ":")
        return Time(hour: Int(components[0])!, minute: Int(components[1])!)
    }
    
    static func next(in components: [(year: Int, month: Int, day: Int)], from date: Date = Date()) -> Date {
        for component in components {
            let next: Date = Calendar.shared.date(from: DateComponents(timeZone: .shared, year: component.year, month: component.month, day: component.day))!
            if date > next {
                continue
            }
            return next
        }
        return Date(timeIntervalSince1970: 0.0)
    }
    
    static func next(month: Int, day: Int, from date: Date = Date()) -> Date {
        let year: Int = year(from: date)
        let next: Date = Calendar.shared.date(from: DateComponents(timeZone: .shared, year: year, month: month, day: day))!
        if date > next {
            return Calendar.shared.date(from: DateComponents(timeZone: .shared, year: year + 1, month: month, day: day))!
        }
        return next
    }
    
    static func date(near date: Date = Date(), html: String?) -> Date? {
        guard let html: String = html else {
            return nil
        }
        let dateInterval: DateInterval = DateInterval(start: Date(timeInterval: -15778800.0, since: date), duration: 31557600.0)
        let years: [String] = [yyyy.string(from: dateInterval.start), yyyy.string(from: dateInterval.end)]
        for year in years {
            guard let htmlDate: Date = Mdyyyy.date(from: "\(html)/\(year)"), dateInterval.contains(htmlDate) else {
                continue
            }
            return htmlDate
        }
        return nil
    }
    
    static func day(from date: Date) -> Day {
        let date: Date = Calendar.shared.startOfDay(for: date)
        return Day(rawValue: EEEE.string(from: date).lowercased())!
    }
    
    static func year(from date: Date) -> Int {
        Int(y.string(from: date))!
    }
    
    convenience init(_ dateFormat: String, timeZone: TimeZone = .shared) {
        self.init()
        self.dateFormat = dateFormat
        self.timeZone = timeZone
    }
    
    private static let Hm: DateFormatter = DateFormatter("H:m")
    private static let MMMMd: DateFormatter = DateFormatter("MMMM d")
    private static let MMMd: DateFormatter = DateFormatter("MMM d")
    private static let Mdyyyy: DateFormatter = DateFormatter("M/d/yyyy")
    private static let EEEE: DateFormatter = DateFormatter("EEEE")
    private static let yyyy: DateFormatter = DateFormatter("yyyy")
    private static let y: DateFormatter = DateFormatter("y")
}

private extension Calendar {
    static let shared: Self = Self(identifier: .gregorian, timeZone: .shared)
    
    init(identifier: Identifier, timeZone: TimeZone) {
        self.init(identifier: identifier)
        self.timeZone = timeZone
    }
}

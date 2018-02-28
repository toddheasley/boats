import Foundation

extension DateFormatter {
    public var localization: Localization {
        set {
            timeZone = newValue.timeZone
            locale = newValue.locale
        }
        get {
            var localization: Localization = Localization(timeZone: timeZone)
            localization.locale = locale
            return localization
        }
    }
    
    public convenience init(localization: Localization) {
        self.init()
        self.localization = localization
    }
}

extension DateFormatter {
    public var is24HourTime: Bool {
        let style: (date: Style, time: Style, format: String) = (dateStyle, timeStyle, dateFormat)
        dateStyle = .none
        timeStyle = .medium
        let is24HouTime: Bool = !string(from: Date()).contains(" ")
        dateStyle = style.date
        timeStyle = style.time
        dateFormat = style.format
        return is24HouTime
    }
    
    public func string(from season: Season, style: Style) -> String {
        var string: String = ""
        if let dateInterval: DateInterval = season.dateInterval {
            let format: String = dateFormat
            dateStyle = style
            timeStyle = .none
            string = ": \(self.string(from: dateInterval.start)) - \(self.string(from: dateInterval.end))"
            dateFormat = format
        }
        return "\(season.rawValue.capitalized)\(string)"
    }
    
    public func string(from date: Date, style: Style) -> String {
        let format: String = dateFormat
        dateStyle = style
        timeStyle = .none
        let string: String = self.string(from: date)
        dateFormat = format
        return string
    }
    
    public func string(from time: Time) -> String {
        let format: String = dateFormat
        let date: Date = time.date(timeZone: timeZone)
        var string: String = ""
        if is24HourTime {
            dateFormat = "HH:mm"
            string = self.string(from: date)
        } else {
            dateFormat = "h:mm"
            string = self.string(from: date)
            dateFormat = "a"
            if self.string(from: date) == pmSymbol {
                string += "."
            }
        }
        dateFormat = format
        return string
    }
    
    public func components(from time: Time) -> [String] {
        let format: String = dateFormat
        let date: Date = time.date(timeZone: timeZone)
        var components: [String] = []
        if is24HourTime {
            dateFormat = "HH:mm "
            components.append(contentsOf: self.string(from: date).map { element in
                "\(element)"
            })
        } else {
            dateFormat = "h"
            components.append(contentsOf: self.string(from: date).map { element in
                "\(element)"
            })
            if components.count < 2 {
                components.insert(" ", at: 0)
            }
            components.append(":")
            dateFormat = "mm"
            components.append(contentsOf: self.string(from: date).map { element in
                "\(element)"
            })
            dateFormat = "a"
            components.append(self.string(from: date) == pmSymbol ? "." : " ")
        }
        dateFormat = format
        return components
    }
    
    public func string(from day: Day) -> String {
        return "\(day.rawValue.capitalized)"
    }
    
    public func day(from date: Date = Date()) -> Day {
        let format: String = dateFormat
        dateFormat = "e"
        let string: String = self.string(from: date)
        dateFormat = format
        switch Int(string)! {
        case 1:
            return .sunday
        case 2:
            return .monday
        case 3:
            return .tuesday
        case 4:
            return .wednesday
        case 5:
            return .thursday
        case 6:
            return .friday
        default:
            return .saturday
        }
    }
    
    public convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}

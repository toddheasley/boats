//
//  BoatsKit
//  © 2017 @toddheasley
//

import Foundation

extension DateFormatter {
    public func string(from date: Date, format: Date.Format) -> String {
        dateFormat = format.rawValue
        return string(from: date)
    }
    
    public func date(from string: String, format: Date.Format) -> Date? {
        dateFormat = format.rawValue
        return date(from: string)
    }
}

extension DateFormatter {
    public var localization: Localization {
        var localization: Localization = Localization(timeZone: timeZone)
        localization.locale = locale
        return localization
    }
    
    public convenience init(localization: Localization) {
        self.init()
        self.timeZone = localization.timeZone
        self.locale = localization.locale
    }
}

extension DateFormatter {
    public func day(from date: Date = Date()) -> Day {
        dateFormat = "e"
        switch Int(string(from: date))! {
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
}

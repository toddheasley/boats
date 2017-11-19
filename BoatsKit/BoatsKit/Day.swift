//
// © 2017 @toddheasley
//

import Foundation

public enum Day {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    case holiday
    case special(Date)
    
    public static let all: [Day] = [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday, .holiday]
    
    public var rawValue: String {
        switch self {
        case .monday:
            return "monday"
        case .tuesday:
            return "tuesday"
        case .wednesday:
            return "wednesday"
        case .thursday:
            return "thursday"
        case .friday:
            return "friday"
        case .saturday:
            return "saturday"
        case .sunday:
            return "sunday"
        case .holiday:
            return "holiday"
        case .special:
            return "special"
        }
    }
    
    public var date: Date? {
        switch self {
        case .special(let date):
            return date
        default:
            return nil
        }
    }
    
    public init(localization: Localization, date: Date = Date(), holidays: [Holiday] = []) {
        for holiday in holidays {
            if holiday.date == date {
                self = .holiday
                return
            }
        }
        self = DateFormatter(localization: localization).day(from: date)
    }
}

extension Day: Codable {
    
    // MARK: Codable
    private enum Key: CodingKey {
        case day
        case date
    }
    
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encode(rawValue, forKey: .day)
        if let date: Date = date {
            try container.encode(date, forKey: .date)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Key> = try decoder.container(keyedBy: Key.self)
        let rawValue: String = try container.decode(String.self, forKey: .day)
        if let date: Date = try? container.decode(Date.self, forKey: .date) {
            self = .special(date)
        } else {
            for day in Day.all {
                if day.rawValue == rawValue {
                    self = day
                    return
                }
            }
            throw DecodingError.typeMismatch(Day.self, DecodingError.Context(codingPath: [Key.day], debugDescription: ""))
        }
    }
}

extension Day: Equatable {
    
    // MARK: Equatable
    public static func ==(x: Day, y: Day) -> Bool {
        return x.rawValue == y.rawValue
    }
}

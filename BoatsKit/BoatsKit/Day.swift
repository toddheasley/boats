//
//  BoatsKit
//  © 2017 @toddheasley
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
    
    public var date: Date? {
        switch self {
        case .special(let date):
            return date
        default:
            return nil
        }
    }
}

extension Day: Codable {
    private enum Key: CodingKey {
        case day
        case date
    }
    
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encode(value, forKey: .day)
        if let date: Date = date {
            try container.encode(date, forKey: .date)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Key> = try decoder.container(keyedBy: Key.self)
        let value: String = try container.decode(String.self, forKey: .day)
        if let date: Date = try? container.decode(Date.self, forKey: .date) {
            self = .special(date)
        } else {
            for day in Day.all {
                if day.value == value {
                    self = day
                    return
                }
            }
            throw DecodingError.typeMismatch(Day.self, DecodingError.Context(codingPath: [Key.day], debugDescription: ""))
        }
    }
}

extension Day: Equatable {
    private var value: String {
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
        default:
            return "special"
        }
    }
    
    public static func ==(x: Day, y: Day) -> Bool {
        return x.value == y.value
    }
}

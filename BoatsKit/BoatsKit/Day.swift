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
    
    public init(date: Date = Date(), localization: Localization? = nil, holidays: [Holiday]? = nil) {
        for holiday in holidays ?? [] {
            if holiday.date == date {
                self = .holiday
                return
            }
        }
        self = DateFormatter(localization: localization ?? Localization()).day(from: date)
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
        guard let day = Day(rawValue: rawValue, date: try? container.decode(Date.self, forKey: .date)) else {
            throw DecodingError.typeMismatch(Day.self, DecodingError.Context(codingPath: [Key.day], debugDescription: ""))
        }
        self = day
    }
}

extension Day: RawRepresentable {
    
    // MARK: RawRepresentable
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
    
    public init?(rawValue: String) {
        self.init(rawValue: rawValue, date: nil)
    }
    
    public init?(rawValue: String, date: Date?) {
        switch rawValue {
        case "monday":
            self = .monday
        case "tuesday":
            self = .tuesday
        case "wednesday":
            self = .wednesday
        case "thursday":
            self = .thursday
        case "friday":
            self = .friday
        case "saturday":
            self = .saturday
        case "sunday":
            self = .sunday
        case "holiday":
            self = .holiday
        case "special":
            guard let date = date else {
                fallthrough
            }
            self = .special(date)
        default:
            return nil
        }
    }
}

extension Day: Equatable {
    
    // MARK: Equatable
    public static func ==(x: Day, y: Day) -> Bool {
        return x.rawValue == y.rawValue
    }
}

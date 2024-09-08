import Foundation

public enum Deviation: Sendable, CustomAccessibilityStringConvertible {
    case start(Date), end(Date), except(Day), only(Day)
    
    public var isExpired: Bool {
        switch self {
        case .start(let date):
            return Date() > date
        case .end(let date):
            return Date() > Date(timeInterval: 86400.0, since: date)
        case .except, .only:
            return false
        }
    }
    
    // MARK: CustomAccessibilityStringConvertible
    public var accessibilityDescription: String {
        switch self {
        case .except(let day):
            return "except \(day.accessibilityDescription)"
        case .only(let day):
            return "\(day.accessibilityDescription) only"
        default:
            return description
        }
    }
    
    public var description: String {
        switch self {
        case .start(let date):
            return "\(date < Date() ? "starts" : "started") \(formatter.string(from: date))"
        case .end(let date):
            return "\(date > Date() ? "ends" : "ended") \(formatter.string(from: date))"
        case .except(let day):
            return "except \(day)"
        case .only(let day):
            return "\(day) only"
        }
    }
}

extension Deviation: Equatable, Identifiable {
    
    // MARK: Equatable
    public static func ==(x: Self, y: Self) -> Bool { x.description == y.description }
    
    // MARK: Identifiable
    public var id: String { description }
}

extension Deviation: Codable {
    
    // MARK: Codable
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Key> = try decoder.container(keyedBy: Key.self)
        let `case`: String = try container.decode(String.self, forKey: .case)
        switch `case` {
        case "start":
            self = .start(try container.decode(Date.self, forKey: .date))
        case "end":
            self = .end(try container.decode(Date.self, forKey: .date))
        case "except":
            self = .except(try container.decode(Day.self, forKey: .day))
        case "only":
            self = .only(try container.decode(Day.self, forKey: .day))
        default:
            throw DecodingError.dataCorruptedError(forKey: .case, in: container, debugDescription: "\(`case`)")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        switch self {
        case .start(let date):
            try container.encode("start", forKey: .case)
            try container.encode(date, forKey: .date)
        case .end(let date):
            try container.encode("end", forKey: .case)
            try container.encode(date, forKey: .date)
        case .except(let day):
            try container.encode("except", forKey: .case)
            try container.encode(day, forKey: .day)
        case .only(let day):
            try container.encode("only", forKey: .case)
            try container.encode(day, forKey: .day)
        }
    }
    
    private enum Key: CodingKey {
        case `case`, date, day
    }
}

extension [Deviation] {
    private var start: Deviation? {
        for deviation in self {
            switch deviation {
            case .start:
                return deviation
            default:
                break
            }
        }
        return nil
    }
    
    private var end: Deviation? {
        for deviation in self {
            switch deviation {
            case .end:
                return deviation
            default:
                break
            }
        }
        return nil
    }
    
    private var except: [Day] {
        var days: [Day] = []
        for deviation in self {
            switch deviation {
            case .except(let day):
                days.append(day)
            default:
                break
            }
        }
        return days
    }
    
    private var only: [Day] {
        var days: [Day] = []
        for deviation in self {
            switch deviation {
            case .only(let day):
                days.append(day)
            default:
                break
            }
        }
        return days
    }
    
    // MARK: CustomAccessibilityStringConvertible
    public var accessibilityDescription: String {
        var components: [String] = []
        if let start {
            components.append(start.accessibilityDescription)
        }
        if let end {
            components.append(end.accessibilityDescription)
        }
        if !except.isEmpty {
            components.append("except \(except.accessibilityDescription)")
        } else if !only.isEmpty {
            components.append("\(only.accessibilityDescription) only")
        }
        return components.joined(separator: "; ")
    }
    
    var description: String {
        var components: [String] = []
        if let start {
            components.append(start.description)
        }
        if let end {
            components.append(end.description)
        }
        if !except.isEmpty {
            components.append("except \(except.description)")
        } else if !only.isEmpty {
            components.append("\(only.description) only")
        }
        return components.joined(separator: "; ")
    }
}

private let formatter: DateFormatter = DateFormatter("M/d")

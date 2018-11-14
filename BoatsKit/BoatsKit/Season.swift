import Foundation

public enum Season {
    case spring(DateInterval), summer(DateInterval), fall(DateInterval), winter(DateInterval), evergreen
    
    public func contains(date: Date) -> Bool {
        switch self {
        case .spring(let dateInterval), .summer(let dateInterval), .fall(let dateInterval), .winter(let dateInterval):
            return dateInterval.contains(date)
        case .evergreen:
            return true
        }
    }
}

extension Season: Codable {
    
    // MARK: Codable
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        switch self {
        case .spring(let dateInterval):
            try container.encode("spring", forKey: .season)
            try container.encode(dateInterval, forKey: .dateInterval)
        case .summer(let dateInterval):
            try container.encode("summer", forKey: .season)
            try container.encode(dateInterval, forKey: .dateInterval)
        case .fall(let dateInterval):
            try container.encode("fall", forKey: .season)
            try container.encode(dateInterval, forKey: .dateInterval)
        case .winter(let dateInterval):
            try container.encode("winter", forKey: .season)
            try container.encode(dateInterval, forKey: .dateInterval)
        case .evergreen:
            try container.encode("", forKey: .season)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Key> = try decoder.container(keyedBy: Key.self)
        if let dateInterval: DateInterval = try? container.decode(DateInterval.self, forKey: .dateInterval) {
            switch try container.decode(String.self, forKey: .season) {
            case "spring":
                self = .spring(dateInterval)
            case "summer":
                self = .summer(dateInterval)
            case "fall":
                self = .fall(dateInterval)
            case "winter":
                self = .winter(dateInterval)
            default:
                throw DecodingError.typeMismatch(Season.self, DecodingError.Context(codingPath: [Key.season], debugDescription: ""))
            }
        } else {
            self = .evergreen
        }
    }
    
    private enum Key: CodingKey {
        case season
        case dateInterval
    }
}

extension Season: RawRepresentable {
    
    // MARK: RawRepresentable
    public var rawValue: String {
        switch self {
        case .spring:
            return "spring"
        case .summer:
            return "summer"
        case .fall:
            return "fall"
        case .winter:
            return "winter"
        case .evergreen:
            return "evergreen"
        }
    }
    
    public init?(rawValue: String) {
        self.init(rawValue: rawValue, dateInterval: nil)
    }
    
    public init?(rawValue: String, dateInterval: DateInterval?) {
        switch rawValue {
        case "evergreen":
            self = .evergreen
        default:
            guard let dateInterval: DateInterval = dateInterval else {
                return nil
            }
            switch rawValue {
            case "spring":
                self = .spring(dateInterval)
            case "summer":
                self = .summer(dateInterval)
            case "fall":
                self = .fall(dateInterval)
            case "winter":
                self = .winter(dateInterval)
            default:
                return nil
            }
        }
    }
}

extension Season: Equatable {
    
    // MARK: Equatable
    public static func ==(x: Season, y: Season) -> Bool {
        return x.rawValue == y.rawValue
    }
}

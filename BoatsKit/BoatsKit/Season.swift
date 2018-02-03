import Foundation

public enum Season {
    case spring(DateInterval)
    case summer(DateInterval)
    case fall(DateInterval)
    case winter(DateInterval)
    case evergreen
    
    public var dateInterval: DateInterval? {
        switch self {
        case .spring(let dateInterval), .summer(let dateInterval), .fall(let dateInterval), .winter(let dateInterval):
            return dateInterval
        case .evergreen:
            return nil
        }
    }
    
    public func contains(date: Date) -> Bool {
        return dateInterval?.contains(date) ?? true
    }
}

extension Season: Codable {
    
    // MARK: Codable
    private enum Key: CodingKey {
        case season
        case dateInterval
    }
    
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        switch self {
        case .spring:
            try container.encode("spring", forKey: .season)
        case .summer:
            try container.encode("summer", forKey: .season)
        case .fall:
            try container.encode("fall", forKey: .season)
        case .winter:
            try container.encode("winter", forKey: .season)
        case .evergreen:
            try container.encode("", forKey: .season)
        }
        if let dateInterval: DateInterval = dateInterval {
            try container.encode(dateInterval, forKey: .dateInterval)
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
            guard let dateInterval = dateInterval else {
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

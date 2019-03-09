import Foundation

public enum Deviation {
    case start(Date), end(Date), holiday
    
    public var isExpired: Bool {
        switch self {
        case .start(let date):
            return Date() > date
        case .end(let date):
            return Date() > Date(timeInterval: 86400.0, since: date)
        case .holiday:
            return false
        }
    }
}

extension Deviation: CustomStringConvertible {
    
    // MARK: CustomStringConvertible
    public var description: String {
        DateFormatter.shared.dateFormat = "M/d"
        switch self {
        case .start(let date):
            return "\(isExpired ? "started" : "starts") \(DateFormatter.shared.string(from: date))"
        case .end(let date):
            return "\(isExpired ? "ended" : "ends") \(DateFormatter.shared.string(from: date))"
        case .holiday:
            return "except holiday"
        }
    }
}

extension Deviation: Equatable {
    
    // MARK: Equatable
    public static func ==(x: Deviation, y: Deviation) -> Bool {
        return x.description == y.description
    }
}

extension Deviation: Codable {
    
    // MARK: Decodable
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Key> = try decoder.container(keyedBy: Key.self)
        let `case`: String = try container.decode(String.self, forKey: .case)
        switch `case` {
        case "start":
            self = .start(try container.decode(Date.self, forKey: .date))
        case "end":
            self = .end(try container.decode(Date.self, forKey: .date))
        case "holiday":
            self = .holiday
        default:
            throw(DecodingError.dataCorruptedError(forKey: .case, in: container, debugDescription: "\(`case`)"))
        }
    }
    
    // MARK: Encodable
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        switch self {
        case .start(let date):
            try container.encode("start", forKey: .case)
            try container.encode(date, forKey: .date)
        case .end(let date):
            try container.encode("end", forKey: .case)
            try container.encode(date, forKey: .date)
        case .holiday:
            try container.encode("holiday", forKey: .case)
        }
    }
    
    private enum Key: CodingKey {
        case `case`, date
    }
}

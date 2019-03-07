import Foundation

public enum Deviation {
    case start(Date), end(Date), holiday
}

extension Deviation: CustomStringConvertible {
    public func description(relativeTo date: Date = Date(timeIntervalSince1970: 0.0)) -> String {
        DateFormatter.shared.dateFormat = "M/d"
        switch self {
        case .start(let start):
            return "\(start > date ? "starts" : "started") \(DateFormatter.shared.string(from: start))"
        case .end(let end):
            return "\(Date(timeInterval: 86400.0, since: end) > date ? "ends" : "ended") \(DateFormatter.shared.string(from: end))"
        case .holiday:
            return "except holiday"
        }
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        return description()
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

import Foundation

public struct Time: CustomStringConvertible {
    public let interval: TimeInterval
    
    public var minute: Int {
        return Int(interval.truncatingRemainder(dividingBy: 3600.0) / 60.0)
    }
    
    public var hour: Int {
        return Int(interval / 3600.0)
    }
    
    public func components(empty string: String = "") -> [String] {
        var components: [String] = []
        if !DateFormatter.shared.is24Hour {
            let hour: Int = hour - (hour > 11 ? 12 : 0)
            switch hour {
            case 10, 11:
                components.append("\(hour)")
            case 0:
                components.append("12")
            default:
                components.append(" \(hour)")
            }
        } else {
            components.append(String(format: "%02d", hour))
        }
        components.append(":")
        components.append(String(format: "%02d", minute))
        if !DateFormatter.shared.is24Hour, hour > 11 {
            components.append(".")
        } else {
            components.append(" ")
        }
        return components.joined().map { "\($0 == " " ? string : "\($0)")" }
    }
    
    public init(interval: TimeInterval) {
        self.interval = TimeInterval(Int(min(max(interval, 0.0), 86340.0) / 60.0) * 60)
    }
    
    public init(hour: Int, minute: Int) {
        self.init(interval: TimeInterval((min(max(hour, 0), 23) * 3600) + (min(max(minute, 0), 59) * 60)))
    }
    
    public init(_ date: Date = Date()) {
        self = DateFormatter.shared.time(from: date)
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        return components().joined()
    }
}

extension Time: Comparable {
    
    // MARK: Comparable
    public static func ==(x: Self, y: Self) -> Bool {
        return x.interval == y.interval
    }
    
    public static func <(x: Self, y: Self) -> Bool {
        return x.interval < y.interval
    }
}

extension Time: Codable {
    
    // MARK: Codable
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Key> = try decoder.container(keyedBy: Key.self)
        self.init(hour: try container.decode(Int.self, forKey: .hour), minute: try container.decode(Int.self, forKey: .minute))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encode(hour, forKey: .hour)
        try container.encode(minute, forKey: .minute)
    }
    
    private enum Key: CodingKey {
        case hour, minute
    }
}

extension Time: HTMLConvertible {
    
    // MARK: HTMLConvertible
    init(from html: String) throws {
        DateFormatter.shared.dateFormat = "ah:mm"
        guard let date: Date = DateFormatter.shared.date(from: html) else {
            throw HTML.error(Self.self, from: html)
        }
        self.init(date)
    }
}

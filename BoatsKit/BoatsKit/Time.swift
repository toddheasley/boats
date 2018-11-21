import Foundation

public struct Time {
    public private(set) var interval: TimeInterval
    
    public var components: (hour: Int, minute: Int) {
        return (Int(interval / 3600.0), Int(interval.truncatingRemainder(dividingBy: 3600.0) / 60.0))
    }
    
    public init(hour: Int, minute: Int) {
        self.init(interval: TimeInterval((min(max(hour, 0), 23) * 3600) + (min(max(minute, 0), 59) * 60)))
    }
    
    public init(interval: TimeInterval) {
        self.interval = TimeInterval(Int(min(max(interval, 0.0), 86340.0) / 60.0) * 60)
    }
    
    public init(date: Date = Date()) {
        self = DateFormatter.shared.time(from: date)
    }
}

extension Time: CustomStringConvertible {
    
    // MARK: CustomStringConvertible
    public var description: String {
        let components: (hour: Int, minute: Int) = self.components
        if DateFormatter.shared.is24Hour {
            return "\(String(format: "%02d", components.hour)):\(String(format: "%02d", components.minute))"
        } else if components.hour > 11 {
            return "\(components.hour == 12 ? 12 : components.hour - 12):\(String(format: "%02d", components.minute))."
        } else {
            return "\(components.hour == 0 ? 12 : components.hour):\(String(format: "%02d", components.minute))"
        }
    }
}

extension Time: Comparable {
    
    // MARK: Comparable
    public static func ==(x: Time, y: Time) -> Bool {
        return x.interval == y.interval
    }
    
    public static func <(x: Time, y: Time) -> Bool {
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
        try container.encode(components.hour, forKey: .hour)
        try container.encode(components.minute, forKey: .minute)
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
            throw(HTML.error(Time.self, from: html))
        }
        self.init(date: date)
    }
}

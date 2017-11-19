//
// © 2017 @toddheasley
//

import Foundation

public struct Time {
    public private(set) var timeInterval: TimeInterval = 0.0
    
    public var components: (hour: Int, minute: Int, second: Int) {
        return (Int(timeInterval / 3600.0), Int(timeInterval.truncatingRemainder(dividingBy: 3600.0) / 60.0), Int(timeInterval.truncatingRemainder(dividingBy: 60.0)))
    }
    
    public init(timeInterval: TimeInterval) {
        self.timeInterval = TimeInterval(Int(timeInterval)).truncatingRemainder(dividingBy:  86400.0)
    }
}

extension Time {
    public func date(timeZone: TimeZone? = nil) -> Date {
        return Date(timeInterval: timeInterval, since: Date().day(timeZone: timeZone).start)
    }
    
    public init(from date: Date = Date(), timeZone: TimeZone? = nil) {
        var calendar: Calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timeZone ?? .current
        self.timeInterval = date.timeIntervalSince1970 - calendar.startOfDay(for: date).timeIntervalSince1970
    }
}

extension Time: Codable {
    
    // MARK: Codable
    private var value: String {
        func format(_ component: Int) -> String {
            return String(format: "%02d", component)
        }
        return "\(format(components.hour)):\(format(components.minute)):\(format(components.second))Z"
    }
    
    private static func timeInterval(from value: String) -> TimeInterval? {
        let components: [String] = value.replacingOccurrences(of: "Z", with: "").components(separatedBy: ":")
        guard value.count == 9, value.hasSuffix("Z"),
            components.count == 3,
            let hour: Int = Int(components[0]),
            let minute: Int = Int(components[1]),
            let second: Int = Int(components[2]) else {
            return nil
        }
        return TimeInterval((hour * 3600) + (minute * 60) + second)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container: SingleValueEncodingContainer = encoder.singleValueContainer()
        try container.encode(value)
    }
    
    public init(from decoder: Decoder) throws {
        let container: SingleValueDecodingContainer = try decoder.singleValueContainer()
        guard let timeInterval: TimeInterval = Time.timeInterval(from: try container.decode(String.self)) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "")
        }
        self.timeInterval = timeInterval
    }
}

extension Time: Comparable {
    
    // MARK: Comparable
    public static func ==(x: Time, y: Time) -> Bool {
        return x.timeInterval == y.timeInterval
    }
    
    public static func <(x: Time, y: Time) -> Bool {
        return x.timeInterval < y.timeInterval
    }
}

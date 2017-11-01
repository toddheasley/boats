//
//  Time.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public struct Time {
    public fileprivate(set) var hour: Int
    public fileprivate(set) var minute: Int
}

extension Time: JSONEncoding, JSONDecoding {
    var JSON: Any {
        return [
            String(format: "%02d", hour),
            String(format: "%02d", minute)
        ].joined(separator: ":")
    }
    
    init?(JSON: Any) {
        guard let JSON = JSON as? String else {
            return nil
        }
        let components = JSON.split { $0 == ":" }.map { String($0) }
        if components.count != 2 {
            return nil
        }
        guard let hour = Int(components[0]), let minute = Int(components[1]) else {
            return nil
        }
        self.hour = min(23, max(0, hour))
        self.minute = min(59, max(0, minute))
    }
}

extension Time: DateDecoding {
    public init(date: Foundation.Date = Foundation.Date()) {
        Date.formatter.dateFormat = "HH:mm"
        self.init(JSON: Date.formatter.string(from: date) as AnyObject)!
    }
}

extension Time: Comparable {
    private var value: Int {
        return Int([
            String(format: "%02d", hour),
            String(format: "%02d", minute)
        ].joined())!
    }
    
    public static func ==(x: Time, y: Time) -> Bool {
        return x.value == y.value
    }
    
    public static func <(x: Time, y: Time) -> Bool {
        return x.value < y.value
    }
}

extension Time {
    private static let formatter: DateFormatter = DateFormatter()
    
    public static var is24Hour: Bool {
        Time.formatter.dateStyle = .none
        Time.formatter.timeStyle = .short
        return !Time.formatter.string(from: Foundation.Date()).contains(" ")
    }
    
    public var components: [String] {
        let hours: String = String(format: "%02d", (!Time.is24Hour && (hour < 1 || hour > 12)) ? abs(hour - 12) : hour)
        let minutes: String = String(format: "%02d", minute)
        let separator: String = ":"
        let period: String = (!Time.is24Hour && (hour > 11 )) ? "." : ""
        return [
            "\(hours.first!)",
            "\(hours.last!)",
            separator,
            "\(minutes.first!)",
            "\(minutes.last!)",
            period
        ]
    }
    
    public var string: String {
        return (components.joined() as NSString).replacingOccurrences(of: "0", with: "", options: .caseInsensitive, range: NSMakeRange(0, 1))
    }
    
    public static func components(_ time: Time? = nil) -> [String] {
        return time?.components ?? ["0", "0", ":", "0", "0", "."]
    }
    
    public static func string(_ time: Time? = nil) -> String {
        return time?.string ?? "--:--"
    }
}

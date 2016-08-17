//
//  Time.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public struct Time {
    public internal(set) var hour: Int
    public internal(set) var minute: Int
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
        let components = JSON.characters.split { $0 == ":" }.map { String($0) }
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
        ].joined(separator: ""))!
    }
    
    public static func ==(x: Time, y: Time) -> Bool {
        return x.value == y.value
    }
    
    public static func <(x: Time, y: Time) -> Bool {
        return x.value < y.value
    }
}

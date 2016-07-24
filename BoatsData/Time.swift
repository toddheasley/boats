//
//  Time.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public struct Time {
    public private(set) var hour: Int
    public private(set) var minute: Int
}

extension Time: JSONEncoding, JSONDecoding {
    var JSON: AnyObject {
        return [
            String(format: "%02d", hour),
            String(format: "%02d", minute)
        ].joined(separator: ":")
    }
    
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? String else {
            return nil
        }
        let components = JSON.characters.split { $0 == ":" }.map { String($0) }
        if (components.count != 2) {
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
        self.init(JSON: Date.formatter.string(from: date))!
    }
}

extension Time: Comparable {
    var value: Int {
        return Int([
            String(format: "%02d", hour),
            String(format: "%02d", minute)
        ].joined(separator: ""))!
    }
}

public func ==(x: Time, y: Time) -> Bool {
    return x.value == y.value
}

public func <(x: Time, y: Time) -> Bool {
    return x.value < y.value
}

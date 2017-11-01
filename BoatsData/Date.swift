//
//  Date.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

protocol DateEncoding {
    var date: Foundation.Date {
        get
    }
}

protocol DateDecoding {
    init(date: Foundation.Date)
}

public struct Date {
    static let formatter: DateFormatter = DateFormatter()
    public fileprivate(set) var year: Int
    public fileprivate(set) var month: Int
    public fileprivate(set) var day: Int
}

extension Date: JSONEncoding, JSONDecoding {
    var JSON: Any {
        return [
            String(format: "%04d", year),
            String(format: "%02d", month),
            String(format: "%02d", day)
            ].joined(separator: "-")
    }
    
    init?(JSON: Any) {
        guard let JSON = JSON as? String else {
            return nil
        }
        let components = JSON.split { $0 == "-" }.map { String($0) }
        if components.count != 3 {
            return nil
        }
        guard let year = Int(components[0]), let month = Int(components[1]), let day = Int(components[2]) else {
            return nil
        }
        self.year = max(1970, year)
        self.month = max(1, month)
        self.month = min(12, self.month)
        self.day = max(1, day)
        switch self.month {
        case 4, 6, 9, 11:
            self.day = min(30, self.day)
        case 2:
            self.day = min(((self.year - 2012) % 4 == 0) ? 29 : 28, self.day)
        default:
            self.day = min(31, self.day)
        }
    }
}

extension Date: DateEncoding, DateDecoding {
    public var date: Foundation.Date {
        Date.formatter.dateFormat = "yyyy-MM-dd"
        return Date.formatter.date(from: JSON as! String)!
    }
    
    public init(date: Foundation.Date = Foundation.Date()) {
        Date.formatter.dateFormat = "yyyy-MM-dd"
        self.init(JSON: Date.formatter.string(from: date) as AnyObject)!
    }
}

extension Date: Comparable {
    private var value: Int {
        return Int([
            String(format: "%04d", year),
            String(format: "%02d", month),
            String(format: "%02d", day)
        ].joined(separator: ""))!
    }
    
    public static func ==(x: Date, y: Date) -> Bool {
        return x.value == y.value
    }
    
    public static func <(x: Date, y: Date) -> Bool {
        return x.value < y.value
    }
}

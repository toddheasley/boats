//
//  Date.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public struct Date {
    public private(set) var year: Int
    public private(set) var month: Int
    public private(set) var day: Int
}

extension Date: JSONEncoding, JSONDecoding {
    var JSON: AnyObject {
        return [
            String(format: "%04d", year),
            String(format: "%02d", month),
            String(format: "%02d", day)
            ].joinWithSeparator("-")
    }
    
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? String else {
            return nil
        }
        let components = JSON.characters.split{$0 == "-"}.map{String($0)}
        if (components.count != 3) {
            return nil
        }
        guard let year = Int(components[0]), month = Int(components[1]), day = Int(components[2]) else {
            return nil
        }
        self.year = max(2016, year)
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

extension Date: NSDateDecoding {
    public init?(date: NSDate = NSDate()) {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.init(JSON: dateFormatter.stringFromDate(date))
    }
}

extension Date: Comparable {
    var value: Int {
        return Int([
            String(format: "%04d", year),
            String(format: "%02d", month),
            String(format: "%02d", day)
        ].joinWithSeparator(""))!
    }
}

public func ==(x: Date, y: Date) -> Bool {
    return x.value == y.value
}

public func <(x: Date, y: Date) -> Bool {
    return x.value < y.value
}

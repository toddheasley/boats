//
//  Date.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import Foundation

struct Date: JSONDecoding, JSONEncoding {
    static var format: String = "yyyy-MM-dd"
    private(set) var year: Int
    private(set) var month: Int
    private(set) var day: Int
    
    var value: Int {
        return Int([
            String(format: "%04d", year),
            String(format: "%02d", month),
            String(format: "%02d", day)
        ].joinWithSeparator(""))!
    }
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return [
            String(format: "%04d", year),
            String(format: "%02d", month),
            String(format: "%02d", day)
            ].joinWithSeparator("-")
    }
    
    // MARK JSONDecoding
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? String else {
            return nil
        }
        let components = JSON.characters.split{$0 == "-"}.map{String($0)}
        if (components.count != 3) {
            return nil
        }
        guard let year = Int(components[0]), let month = Int(components[1]), let day = Int(components[2]) else {
            return nil
        }
        self.year = max(2015, year)
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

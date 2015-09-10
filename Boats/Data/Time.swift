//
//  Time.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import Foundation

struct Time: JSONDecoding, JSONEncoding {
    static var format: String = "HH:mm"
    private(set) var hour: Int
    private(set) var minute: Int
    
    var value: Int {
        return Int([
            String(format: "%02d", hour),
            String(format: "%02d", minute)
        ].joinWithSeparator(""))!
    }
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return [
            String(format: "%02d", hour),
            String(format: "%02d", minute)
        ].joinWithSeparator(":")
    }
    
    // MARK JSONDecoding
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? String else {
            return nil
        }
        let components = JSON.characters.split{$0 == ":"}.map{String($0)}
        if (components.count != 2) {
            return nil
        }
        guard let hour = Int(components[0]), let minute = Int(components[1]) else {
            return nil
        }
        self.hour = max(0, hour)
        self.hour = min(23, self.hour)
        self.minute = max(0, minute)
        self.minute = min(59, self.minute)
    }
}

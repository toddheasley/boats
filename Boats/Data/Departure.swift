//
//  Departure.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import Foundation

struct Departure: JSONDecoding, JSONEncoding {
    private(set) var days: [Day]
    private(set) var time: Time
    private(set) var direction: Direction
    private(set) var cars: Bool = false
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return [
            "days": days.map{$0.rawValue},
            "time": time.JSON,
            "direction": direction.rawValue,
            "cars": cars
        ]
    }
    
    // MARK: JSONDecoding
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? [String: AnyObject], let _ = JSON["days"] as? [String], let _ = JSON["days"] as? [String], let _ = JSON["time"] as? String, let time = Time(JSON: JSON["time"]!), let _ = JSON["direction"] as? String, let direction = Direction(rawValue: JSON["direction"] as! String), let cars = JSON["cars"] as? Bool else {
            return nil
        }
        var days: [Day] = []
        for dayJSON in (JSON["days"] as! [String]) {
            guard let day = Day(rawValue: dayJSON) else {
                return nil
            }
            days.append(day)
        }
        if (direction == .Both) {
            return nil
        }
        self.days = days
        self.time = time
        self.direction = direction
        self.cars = cars
    }
}

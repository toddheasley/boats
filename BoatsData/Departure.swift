//
//  Departure.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public struct Departure {
    public private(set) var days: [Day]
    public private(set) var time: Time
    public private(set) var direction: Direction
    public private(set) var cars: Bool = false
}

extension Departure: JSONEncoding, JSONDecoding {
    var JSON: AnyObject {
        return [
            "days": days.map{$0.rawValue},
            "time": time.JSON,
            "direction": direction.rawValue,
            "cars": cars
        ]
    }
    
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? [String: AnyObject], _ = JSON["days"] as? [String], _ = JSON["days"] as? [String], _ = JSON["time"] as? String, time = Time(JSON: JSON["time"]!), _ = JSON["direction"] as? String, direction = Direction(rawValue: JSON["direction"] as! String), cars = JSON["cars"] as? Bool else {
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

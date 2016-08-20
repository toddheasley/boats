//
//  Departure.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public struct Departure {
    public fileprivate(set) var days: [Day]
    public fileprivate(set) var time: Time
    public fileprivate(set) var direction: Direction
    public fileprivate(set) var cars: Bool = false
}

extension Departure: JSONEncoding, JSONDecoding {
    var JSON: Any {
        return [
            "days": days.map { $0.rawValue },
            "time": time.JSON,
            "direction": direction.rawValue,
            "cars": cars
        ]
    }
    
    init?(JSON: Any) {
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
        if direction == .both {
            return nil
        }
        self.days = days
        self.time = time
        self.direction = direction
        self.cars = cars
    }
}

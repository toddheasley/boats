//
//  File.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public struct Route {
    public private(set) var name: String
    public private(set) var code: String
    public private(set) var destination: Location
    public private(set) var origin: Location
    public private(set) var schedules: [Schedule]
    
    public func schedule(date: Date) -> Schedule? {
        for schedule in schedules {
            if (date.value >= schedule.dates.start.value && date.value <= schedule.dates.end.value) {
                return schedule
            }
        }
        return nil
    }
}

extension Route: JSONEncoding, JSONDecoding {
    var JSON: AnyObject {
        return [
            "name": name,
            "code": code,
            "destination": destination.JSON,
            "origin": origin.JSON,
            "schedules": schedules.map{$0.JSON}
        ]
    }
    
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? [String: AnyObject], name = JSON["name"] as? String, code = JSON["code"] as? String, _ = JSON["destination"], destination = Location(JSON: JSON["destination"]!), _ = JSON["origin"], origin = Location(JSON: JSON["origin"]!), _ = JSON["schedules"] as? [AnyObject] else {
            return nil
        }
        var schedules: [Schedule] = []
        for scheduleJSON in (JSON["schedules"] as! [AnyObject]) {
            guard let scheduleJSON = scheduleJSON as? [String: AnyObject], schedule = Schedule(JSON: scheduleJSON) else {
                return nil
            }
            schedules.append(schedule)
        }
        self.name = name
        self.code = code
        self.destination = destination
        self.origin = origin
        self.schedules = schedules
    }
}

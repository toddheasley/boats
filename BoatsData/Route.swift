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
    
    public func schedule(date: Date = Date()) -> Schedule? {
        for schedule in schedules {
            if schedule.contains(date: date) {
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
            "schedules": schedules.map { $0.JSON }
        ]
    }
    
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? [String: AnyObject], let name = JSON["name"] as? String, let code = JSON["code"] as? String, let _ = JSON["destination"], let destination = Location(JSON: JSON["destination"]!), let _ = JSON["origin"], let origin = Location(JSON: JSON["origin"]!), let _ = JSON["schedules"] as? [AnyObject] else {
            return nil
        }
        var schedules: [Schedule] = []
        for scheduleJSON in (JSON["schedules"] as! [AnyObject]) {
            guard let scheduleJSON = scheduleJSON as? [String: AnyObject], let schedule = Schedule(JSON: scheduleJSON) else {
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

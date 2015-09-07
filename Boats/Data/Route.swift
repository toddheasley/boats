//
//  File.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import Foundation

struct Route: JSONDecoding, JSONEncoding {
    private(set) var name: String
    private(set) var code: String
    private(set) var destination: Location
    private(set) var origin: Location
    private(set) var schedules: [Schedule]
    
    func schedule(date: Date) -> Schedule? {
        for schedule in schedules {
            if (date.value >= schedule.dates.start.value && date.value <= schedule.dates.end.value) {
                return schedule
            }
        }
        return nil
    }
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return [
            "name": name,
            "code": code,
            "destination": destination.JSON,
            "origin": origin.JSON,
            "schedules": schedules.map{$0.JSON}
        ]
    }
    
    // MARK: JSONDecoding
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

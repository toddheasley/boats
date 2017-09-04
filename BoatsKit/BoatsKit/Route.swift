//
//  BoatsKit
//  © 2017 @toddheasley
//

import Foundation

public struct Route: Codable {
    public var uri: URI = ""
    public var name: String = ""
    public var destination: Location = Location()
    public var origin: Location = Location()
    public var services: [Service] = []
    public var schedules: [Schedule] = []
    
    public func schedule(for date: Date = Date()) -> Schedule? {
        for schedule in schedules {
            if schedule.season.dateInterval == nil || schedule.season.dateInterval?.contains(date) ?? false {
                return schedule
            }
        }
        return nil
    }
}

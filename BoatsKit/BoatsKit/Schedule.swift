//
// © 2017 @toddheasley
//

import Foundation

public struct Schedule: Codable {
    public var season: Season = .evergreen
    public var holidays: [Holiday] = []
    public var departures: [Departure] = []
    
    public var days: [Day] {
        return Day.all.filter { day in
            contains(day: day)
        }
    }
    
    public func contains(day: Day) -> Bool {
        return !departures.filter { departure in
            departure.days.contains(day)
        }.isEmpty
    }
    
    public func departures(day: Day, direction: Departure.Direction = .destination) -> [Departure] {
        return departures.filter { departure in
            return departure.days.contains(day) && departure.direction == direction
        }
    }
    
    public func departures(index: Int) -> Departure? {
        guard index >= 0, index < departures.count else {
            return nil
        }
        return departures[index]
    }
    
    public func next(day: Day, time: Time = Time(), direction: Departure.Direction = .destination) -> Departure? {
        for departure in departures(day: day, direction: direction) {
            if departure.time > time {
                return departure
            }
        }
        return nil
    }
    
    public init() {
        
    }
}

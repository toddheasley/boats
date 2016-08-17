//
//  Schedule.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public struct Schedule {
    public internal(set) var season: Season
    public internal(set) var dates: (start: Date, end: Date)
    public internal(set) var holidays: [Holiday]
    public internal(set) var departures: [Departure]
    
    public var days: [Day] {
        return Day.days.filter { contains(day: $0) || ($0 != .holiday && contains(day: .everyday)) }
    }
    
    public var day: Day {
        let date: Date = Date()
        for holiday in holidays {
            if holiday.date == date {
                return .holiday
            }
        }
        return Day()
    }
    
    public func departures(day: Day? = nil, direction: Direction = .both) -> [Departure] {
        return departures.filter {
            return ($0.days.contains(day ?? self.day) || $0.days.contains(.everyday)) && ($0.direction == direction || direction == .both)
        }
    }
    
    public func departure(direction: Direction = .destination) -> Departure? {
        let time: Time = Time()
        for departure in departures(direction: direction) {
            if departure.time > time {
                return departure
            }
        }
        return nil
    }
    
    public func contains(day: Day) -> Bool {
        return !departures.filter { $0.days.contains(day) }.isEmpty
    }
    
    public func contains(date: Date) -> Bool {
        return date >= dates.start && date <= dates.end
    }
}

extension Schedule: JSONEncoding, JSONDecoding {
    var JSON: Any {
        return [
            "season": season.rawValue,
            "dates": "\(dates.start.JSON),\(dates.end.JSON)",
            "holidays": holidays.map { $0.JSON },
            "departures": departures.map { $0.JSON }
        ]
    }
    
    init?(JSON: Any) {
        guard let JSON = JSON as? [String: AnyObject], let _ = JSON["season"] as? String, let season = Season(rawValue: JSON["season"] as! String), let dates = JSON["dates"] as? String, let _ = JSON["holidays"] as? [AnyObject], let _ = JSON["departures"] as? [AnyObject] else {
            return nil
        }
        let components = dates.characters.split { $0 == "," }.map { String($0) }
        if components.count != 2 {
            return nil
        }
        guard let start = Date(JSON: components[0] as AnyObject), let end = Date(JSON: components[1] as AnyObject) else {
            return nil
        }
        var holidays: [Holiday] = []
        for holidayJSON in (JSON["holidays"] as! [AnyObject]) {
            guard let holidayJSON = holidayJSON as? [String: String], let holiday = Holiday(JSON: holidayJSON as AnyObject) else {
                return nil
            }
            holidays.append(holiday)
        }
        var departures: [Departure] = []
        for departureJSON in (JSON["departures"] as! [AnyObject]) {
            guard let departureJSON = departureJSON as? [String: AnyObject], let departure = Departure(JSON: departureJSON as AnyObject) else {
                return nil
            }
            departures.append(departure)
        }
        self.season = season
        self.dates = (start: start, end: end)
        self.holidays = holidays
        self.departures = departures
    }
}

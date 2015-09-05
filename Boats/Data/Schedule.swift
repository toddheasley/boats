//
//  Schedule.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import Foundation

struct Schedule: JSONDecoding, JSONEncoding {
    private(set) var season: Season
    private(set) var dates: (start: Date, end: Date)
    private(set) var holidays: [Holiday]
    private(set) var departures: [Departure]
    
    func departures(day: Day, direction: Direction = .Both) -> [Departure] {
        return departures.filter{
            return ($0.days.contains(day) || $0.days.contains(.Everyday)) && ($0.direction == direction || direction == .Both)
        }
    }
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return [
            "season": season.rawValue,
            "dates": "\(dates.start.JSON),\(dates.end.JSON)",
            "holidays": holidays.map{$0.JSON},
            "departures": departures.map{$0.JSON}
        ]
    }
    
    // MARK: JSONDecoding
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? [String: AnyObject], let _ = JSON["season"] as? String, let season = Season(rawValue: JSON["season"] as! String), let dates = JSON["dates"] as? String, let _ = JSON["holidays"] as? [AnyObject], let _ = JSON["departures"] as? [AnyObject] else {
            return nil
        }
        let components = dates.characters.split{$0 == ","}.map{String($0)}
        if (components.count != 2) {
            return nil
        }
        guard let start = Date(JSON: components[0]), let end = Date(JSON: components[1]) else {
            return nil
        }
        var holidays: [Holiday] = []
        for holidayJSON in (JSON["holidays"] as! [AnyObject]) {
            guard let holidayJSON = holidayJSON as? [String: String], let holiday = Holiday(JSON: holidayJSON) else {
                return nil
            }
            holidays.append(holiday)
        }
        var departures: [Departure] = []
        for departureJSON in (JSON["departures"] as! [AnyObject]) {
            guard let departureJSON = departureJSON as? [String: AnyObject], let departure = Departure(JSON: departureJSON) else {
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

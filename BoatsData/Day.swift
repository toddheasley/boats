//
//  Day.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public enum Day: String {
    case everyday = "Everyday"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"
    case holiday = "Holiday"
    
    public static var days: [Day] {
        return [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday, .holiday]
    }
}

extension Day: DateDecoding {
    public init(date: Foundation.Date = Foundation.Date()) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        self.init(rawValue: dateFormatter.string(from: date))!
    }
}

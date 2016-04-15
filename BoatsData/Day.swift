//
//  Day.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public enum Day: String {
    case Everyday = "Everyday"
    case Monday = "Monday"
    case Tuesday = "Tuesday"
    case Wednesday = "Wednesday"
    case Thursday = "Thursday"
    case Friday = "Friday"
    case Saturday = "Saturday"
    case Sunday = "Sunday"
    case Holiday = "Holiday"
}

extension Day: NSDateDecoding {
    public init?(date: NSDate = NSDate()) {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        self.init(rawValue: dateFormatter.stringFromDate(date))
    }
}

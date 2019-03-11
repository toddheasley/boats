import Foundation
import BoatsKit

public struct Complication {
    public private(set) var day: Day
    public private(set) var departure: Departure
    public private(set) var destination: Location
    public private(set) var origin: Location
    
    public var date: Date? {
        let date: Date = Calendar.current.startOfDay(for: Date())
        return Date(day: day, time: departure.time, matching: date) ?? Date(day: day, time: departure.time, matching: Calendar.current.startOfDay(for: Date(timeInterval: 129600.0, since: date)))
    }
    
    public var isExpired: Bool {
        guard let deviation: Deviation = departure.deviations.first else {
            return false
        }
        switch deviation {
        case .start:
            return !deviation.isExpired
        case .end:
            return deviation.isExpired
        case .holiday:
            return day == .holiday
        }
    }
    
    public init(day: Day, departure: Departure, destination: Location, origin: Location) {
        self.day = day
        self.departure = departure
        self.destination = destination
        self.origin = origin
    }
}

import Foundation
import BoatsKit

public struct Complication {
    public let day: Day
    public let departure: Departure
    public let destination: Location
    public let origin: Location
    
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
        case .only(let only):
            return day != only
        case .holiday:
            return day == .holiday
        }
    }
}

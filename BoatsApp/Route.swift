import Foundation
import Boats

extension Route {
    typealias LocalDeparture = (location: Location, departure: Departure)
    
    func localDepartures(from date: Date = Date(), limit: Int = -1) -> [LocalDeparture] {
        guard limit != 0 else { return [] }
        var departures: [LocalDeparture] = []
        for dayTrip in dayTrips(from: date) {
            if let departure: Departure = dayTrip.trip.origin {
                departures.append((Location.portland, departure))
            }
            if let departure: Departure = dayTrip.trip.destination {
                departures.append((location, departure))
            }
        }
        if limit > 0, departures.count > limit {
            departures = Array(departures[0..<limit])
        }
        return departures
    }
    
    struct DayTrip {
        let trip: Timetable.Trip
        let day: Day
        
        init(_ trip: Timetable.Trip, day: Day = Day()) {
            self.trip = trip
            self.day = day
        }
        
        init(_ trip: Timetable.Trip, date: Date) {
            self.trip = trip
            self.day = Day(date)
        }
        
        var date: (origin: Date?, destination: Date?) {
            func departure(_ departure: Departure?, for date: Date) -> Date? {
                guard let departure else { return nil }
                let date: Date = Calendar.current.startOfDay(for: date)
                let next: Date = Calendar.current.startOfDay(for: Date(timeInterval: 129600.0, since: date))
                return Date(day: day, time: departure.time, matching: date) ?? Date(day: day, time: departure.time, matching: next)
            }
            
            let date: Date = Date()
            return (departure(trip.origin, for: date), departure(trip.destination, for: date))
        }
    }
    
    func dayTrips(from date: Date = Date(), limit: Int = -1) -> [DayTrip] {
        guard limit != 0 else { return [] }
        let next: Date = Calendar.current.startOfDay(for: Date(timeInterval: 129600.0, since: Calendar.current.startOfDay(for: date)))
        var dayTrips: [DayTrip] = tripsRemaining(on: date) + tripsRemaining(on: next)
        if limit > 0, dayTrips.count > limit {
            dayTrips = Array(dayTrips[0..<limit])
        }
        return dayTrips
    }
    
    func tripsRemaining(on date: Date = Date()) -> [DayTrip] {
        return (timetable(for: date)?.trips(from: Time(date)) ?? []).map { DayTrip($0, date: date) }
    }
    
    func timetable(for date: Date = Date()) -> Timetable? {
        return schedule(for: date)?.timetable(for: Day(date))
    }
    
    var codename: String {
        switch self {
        case .littleDiamond:
            return "LDI"
        case .greatDiamond:
            return "GDI"
        case .diamondCove:
            return "COVE"
        case .chebeague:
            return "CHEB"
        default:
            return location.nickname.uppercased()
        }
    }
}

// MARK: Date
private extension Date {
    init?(day: Day, time: Time, matching date: Date = Date()) {
        let date: Date = Calendar.current.startOfDay(for: date)
        guard Day(date) == day else { return nil }
        var components: DateComponents = DateComponents()
        components.hour = time.hour
        components.minute = time.minute
        guard let next: Date = Calendar.current.nextDate(after: date, matching: components, matchingPolicy: .nextTime) else { return nil }
        self = next
    }
}

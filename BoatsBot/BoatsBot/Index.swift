import Foundation
import BoatsKit

extension Index {
    public var route: Route? {
        return current ?? routes.first
    }
    
    public var current: Route? {
        set {
            UserDefaults.shared.set(data: newValue?.uri.data(using: .utf8), for: Key.current)
        }
        get {
            guard let data: Data = UserDefaults.shared.data(for: Key.current),
                let uri: String = String(data: data, encoding: .utf8), !uri.isEmpty else {
                    return nil
            }
            for route in routes {
                if route.uri == uri {
                    return route
                }
            }
            return nil
        }
    }
    
    static var context: [String: Any] {
        set {
            UserDefaults.shared.set(data: newValue[Key.current.stringValue] as? Data, for: Key.current)
        }
        get {
            var context: [String: Any] = [:]
            if let current: Data = UserDefaults.shared.data(for: Key.current) {
                context[Key.current.stringValue] = current
            }
            return context
        }
    }
    
    private enum Key: CodingKey, CaseIterable {
        case current
    }
}

extension Index {
    public func complications(from date: Date = Date(), limit: Int = 100, filter: Bool = false) -> [Complication] {
        guard limit > 0 else {
            return []
        }
        var complications: [Complication] = self.complications(date)
        if complications.count < limit {
            complications.append(contentsOf: self.complications(Calendar.current.startOfDay(for: Date(timeInterval: 129600.0, since: Calendar.current.startOfDay(for: date)))))
        }
        if filter {
            complications = complications.filter { complication in
                return !complication.isExpired
            }
        }
        if complications.count > limit {
            complications = Array(complications[0..<limit])
        }
        return complications
    }
    
    private func complications(_ date: Date) -> [Complication] {
        let day: Day = Day(date: date)
        guard let route: Route = current ?? routes.first,
            let trips: [Timetable.Trip] = route.schedule(for: date)?.timetable(for: day)?.trips(from: Time(date: date)) else {
            return []
        }
        var complications: [Complication] = []
        for trip in trips {
            if let departure: Departure = trip.origin {
                complications.append(Complication(day: day, departure: departure, destination: route.location, origin: location))
            }
            if let departure: Departure = trip.destination {
                complications.append(Complication(day: day, departure: departure, destination: location, origin: route.location))
            }
        }
        return complications
    }
}

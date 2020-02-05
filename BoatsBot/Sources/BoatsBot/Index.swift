import Foundation
import BoatsKit

extension Index {
    public var route: Route? {
        return current ?? routes.first
    }
    
    public var current: Route? {
        set {
            UserDefaults.shared.current = newValue?.uri
        }
        get {
            guard let uri: String = UserDefaults.shared.current, !uri.isEmpty else {
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
        guard let route: Route = route,
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

extension Index {
    public static let contextDidChangeNotification: Notification.Name = Notification.Name("contextDidChange")
    
    public static var context: [String: Any] {
        set {
            UserDefaults.shared.current = newValue["current"] as? String
        }
        get {
            return [
                "current": UserDefaults.shared.current as Any
            ]
        }
    }
}

extension Index {
    func cache() {
        guard let cache: Cache = Cache(index: self),
            let data: Data = try? JSONEncoder().encode(cache) else {
            return
        }
        UserDefaults.shared.set(data, forKey: "cache")
    }
    
    init?(cache timeInterval: TimeInterval) {
        guard let data: Data = UserDefaults.shared.data(forKey: "cache"),
            let cache: Cache = try? JSONDecoder().decode(Cache.self, from: data), Date() < Date(timeInterval: timeInterval, since: cache.date),
            let index: Index = cache.index else {
            return nil
        }
        self = index
    }
}

extension UserDefaults {
    fileprivate var current: String? {
        set {
            guard newValue != current else {
                return
            }
            set(newValue, forKey: "current")
            NotificationCenter.default.post(Notification(name: Index.contextDidChangeNotification))
        }
        get {
            return string(forKey: "current")
        }
    }
}

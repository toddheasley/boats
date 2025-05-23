import Foundation

public struct Timetable: Sendable, Codable, CustomAccessibilityStringConvertible {
    public struct Trip: Sendable, Codable {
        public let origin: Departure?
        public let destination: Departure?
        
        public init(origin: Departure? = nil, destination: Departure? = nil) {
            self.origin = origin
            self.destination = destination
        }
    }
    
    public let trips: [Trip]
    public let days: [Day]
    
    public func trips(from time: Time = Time()) -> [Trip] {
        var trips: [Trip] = []
        for trip in self.trips {
            if let origin: Departure = trip.origin, origin.time > time {
                trips.append(trip)
            } else if let destination: Departure = trip.destination, destination.time > time {
                trips.append(Trip(origin: nil, destination: destination))
            }
        }
        return trips
    }
    
    // MARK: CustomAccessibilityStringConvertible
    public var accessibilityDescription: String { days.accessibilityDescription }
    public var description: String { days.description }
}

extension Timetable.Trip: Identifiable {
    
    // MARK: Identifiable
    public var id: String { "\(origin?.description ?? "") \(destination?.description ?? "")" }
}

extension Timetable: Identifiable {
    
    // MARK: Identifiable
    public var id: String { days.map { $0.rawValue }.joined() }
}

extension Timetable: HTMLConvertible {
    
    // MARK: HTMLConvertible
    init(from html: String) throws {
        guard let components: [String] = html.find("<tbody(.*?)</tbody").first?.find("<tr[^>]*>(.*?)</tr>"), components.count >  1,
              let dayComponents: [String] = html.find("<thead>(.*?)</thead>").first?.replacingOccurrences(of: "&nbsp;", with: "").stripHTML().components(separatedBy: "/") else {
            throw HTML.error(Self.self, from: html)
        }
        var trips: [Trip] = []
        var meridiem: String  = "AM"
        for trip in Array(components.dropFirst()) {
            if trip.contains("PM") {
                meridiem = "PM"
            }
            let start: Int = trip.contains("column-3") ? 2 : 1
            let origin: Departure? = try? Departure(from: "\(meridiem)\(trip.find("<td[^>]class=\"column-\(start)\">(.*?)</td>").first?.trim() ?? "")")
            let destination:Departure? = try? Departure(from: "\(meridiem)\(trip.find("<td[^>]class=\"column-\(start + 1)\">(.*?)</td>").first?.trim() ?? "")")
            guard (origin != nil || destination != nil) else {
                continue
            }
            trips.append(Trip(origin: origin, destination: destination))
        }
        var days: [Day] = []
        for dayComponent in dayComponents {
            let dayInterval: [String] = dayComponent.components(separatedBy: "-")
            let dayGrouping: [String] = dayComponent.components(separatedBy: "&amp;")
            if dayInterval.count == 2,
                let beginning: Day = try? Day(from: dayInterval[0]),
                let ending: Day = try? Day(from: dayInterval[1]) {
                let week: [Day] = Day.week(beginning: beginning)
                days.append(contentsOf: week[0...(week.firstIndex(of: ending)!)])
            } else if dayGrouping.count == 2,
                let first: Day = try? Day(from: dayGrouping[0]),
                let last: Day = try? Day(from: dayGrouping[1]) {
                days.append(contentsOf: [first, last])
            } else if let day: Day = try? Day(from: dayComponent) {
                days.append(day)
            }
        }
        self.init(trips: trips, days: !days.isEmpty ? days : [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday])
    }
}

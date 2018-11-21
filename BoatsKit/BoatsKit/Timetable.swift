import Foundation

public struct Timetable: Codable {
    public struct Trip: Codable {
        public private(set) var origin: Departure?
        public private(set) var destination: Departure?
        
        public init(origin: Departure? = nil, destination: Departure? = nil) {
            self.origin = origin
            self.destination = destination
        }
    }
    
    public private(set) var trips: [Trip]
    public private(set) var days: [Day]
    
    public init(trips: [Trip], days: [Day]) {
        self.trips = trips
        self.days = days
    }
}

extension Timetable: CustomStringConvertible {
    
    // MARK: CustomStringConvertible
    public var description: String {
        return days.map { day in
            day.description
        }.joined(separator: ", ")
    }
}

extension Timetable: HTMLConvertible {
    
    // MARK: HTMLConvertible
    init(from html: String) throws {
        guard let components: [String] = html.find("<tbody>(.*?)</tbody").first?.find("<tr[^>]*>(.*?)</tr>"), components.count > 1,
            let dayComponents: [String] = html.find("<th colspan=\"2\" class=\"column-2\">(.*?)</th>").first?.components(separatedBy: "/") else {
            throw(HTML.error(Timetable.self, from: html))
        }
        var trips: [Trip] = []
        var meridiem: String  = "AM"
        for trip in Array(components.dropFirst()) {
            if trip.contains("PM") {
                meridiem = "PM"
            }
            let origin: Departure? = try? Departure(from: "\(meridiem)\(trip.find("<td[^>]class=\"column-2\">(.*?)</td>").first?.trim() ?? "")")
            let destination:Departure? = try? Departure(from: "\(meridiem)\(trip.find("<td[^>]class=\"column-3\">(.*?)</td>").first?.trim() ?? "")")
            guard (origin != nil || destination != nil) else {
                continue
            }
            trips.append(Trip(origin: origin, destination: destination))
        }
        var days: [Day] = []
        for dayComponent in dayComponents {
            let dayInterval: [String] = dayComponent.components(separatedBy: "-")
            if dayInterval.count == 2,
                let start: Day = try? Day(from: dayInterval[0]),
                let end: Day = try? Day(from: dayInterval[1]),
                let startIndex: Int = Day.allCases.index(of: start),
                let endIndex: Int = Day.allCases.index(of: end), startIndex <= endIndex {
                days.append(contentsOf: Day.allCases[startIndex...endIndex])
            } else if let day: Day = try? Day(from: dayComponent) {
                days.append(day)
            }
        }
        self.init(trips: trips, days: days)
    }
}

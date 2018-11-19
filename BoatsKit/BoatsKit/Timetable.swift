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

import Foundation

public struct Timetable: Codable {
    public struct Trip: Codable {
        public private(set) var origin: Departure?
        public private(set) var destination: Departure?
    }
    
    public private(set) var trips: [Trip]
    public private(set) var days: [Day]
    
    public init(trips: [Trip], days: [Day]) {
        self.trips = trips
        self.days = days
    }
}

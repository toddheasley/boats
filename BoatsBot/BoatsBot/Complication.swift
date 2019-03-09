import Foundation
import BoatsKit

public struct Complication {
    public private(set) var day: Day
    public private(set) var departure: Departure
    public private(set) var destination: Location
    public private(set) var origin: Location
    
    public init(day: Day, departure: Departure, destination: Location, origin: Location) {
        self.day = day
        self.departure = departure
        self.destination = destination
        self.origin = origin
    }
}

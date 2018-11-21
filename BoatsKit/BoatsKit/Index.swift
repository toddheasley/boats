import Foundation
import CoreLocation

public struct Index: CustomStringConvertible, Codable {
    public private(set) var name: String
    public private(set) var description: String
    public private(set) var url: URL
    public private(set) var location: Location
    public private(set) var routes: [Route]
    
    public init() {
        name = "Casco Bay Lines"
        description = "Ferry Schedules"
        url = .build
        location = .portland
        routes = Route.allCases
    }
}

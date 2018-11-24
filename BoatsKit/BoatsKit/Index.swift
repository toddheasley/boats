import Foundation
import CoreLocation

public struct Index: CustomStringConvertible, Codable {
    public private(set) var name: String
    public private(set) var description: String
    public private(set) var url: URL
    public private(set) var location: Location
    public private(set) var routes: [Route]
    public private(set) var uri: String
    
    init(routes: [Route] = Route.allCases) {
        self.name = "Casco Bay Lines"
        self.description = "Ferry Schedules"
        self.url = .build
        self.location = .portland
        self.routes = routes
        self.uri = "index"
    }
}

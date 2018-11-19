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
        url = URL(string: "https://www.cascobaylines.com")!
        location = .portland
        routes = Route.allCases
    }
    
    func scheduleURL(for route: Route, season: Season.Name) -> URL? {
        return URL(string: "\(url)/schedules/\(route.uri)-schedule/\(season.rawValue)")
    }
}



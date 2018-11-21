import Foundation

extension URL {
    static let fetch: URL = URL(string: "https://toddheasley.github.io/boats/index.json")!
    static let build: URL = URL(string: "https://www.cascobaylines.com")!
    
    static func schedule(for route: Route, season: Season.Name) -> URL {
        return URL(string: "\(build.absoluteString)/schedules/\(route.uri)-schedule/\(season.rawValue)")!
    }
}

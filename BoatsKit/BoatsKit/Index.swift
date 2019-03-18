import Foundation
import CoreLocation

public struct Index: CustomStringConvertible, Codable {
    public private(set) var name: String
    public private(set) var description: String
    public private(set) var url: URL
    public private(set) var location: Location
    public private(set) var routes: [Route]
    public private(set) var uri: String
    
    public func route(uri: String) -> Route? {
        for route in routes {
            if route.uri == uri {
                return route
            }
        }
        return nil
    }
    
    public init(routes: [Route] = Route.allCases) {
        self.name = "Casco Bay Lines"
        self.description = "Ferry Schedules"
        self.url = .build
        self.location = .portland
        self.routes = routes
        self.uri = "index"
    }
}

extension Index: Resource {
    public init(from url: URL) throws {
        try self.init(data: try Data(contentsOf: url.appendingPathComponent(Index().path)))
    }
    
    public init(data: Data) throws {
        self = try JSONDecoder.shared.decode(Index.self, from: data)
    }
    
    // MARK: Resource
    public var path: String {
        return "\(uri).json"
    }
    
    public func data() throws -> Data {
        return try JSONEncoder.shared.encode(self)
    }
}

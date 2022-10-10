import CoreLocation

public struct Index: Codable, CustomStringConvertible {
    public let name: String
    public let uri: String
    public let location: Location
    public let routes: [Route]
    public let url: URL
    
    public var route: Route? {
        set { UserDefaults.standard.set(newValue?.uri, forKey: "route") }
        get { route(uri: UserDefaults.standard.string(forKey: "route")) ?? routes.first }
    }
    
    public func route(uri: String?) -> Route? {
        return routes.first { $0.uri == uri }
    }
    
    public init(routes: [Route] = Route.allCases) {
        name = "Casco Bay Lines"
        description = "Ferry Schedules"
        uri = "index"
        location = .portland
        self.routes = routes
        url = .build
    }
    
    // MARK: CustomStringConvertible
    public let description: String
}

extension Index: Resource {
    public init(from url: URL) throws {
        let data: Data = try Data(contentsOf: url.appendingPathComponent(Index().path))
        try self.init(data: data)
    }
    
    public init(data: Data) throws {
        self = try JSONDecoder.shared.decode(Self.self, from: data)
    }
    
    // MARK: Resource
    public var path: String {
        return "\(uri).json"
    }
    
    public func data() throws -> Data {
        return try JSONEncoder.shared.encode(self)
    }
}

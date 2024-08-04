import Foundation

public struct Index: Sendable, Codable, CustomStringConvertible {
    public let name: String
    public let uri: String
    public let location: Location
    public let routes: [Route]
    public let url: URL
    
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
    public var path: String { "\(uri).json" }
    
    public func data() throws -> Data {
        try JSONEncoder.shared.encode(self)
    }
}

//
//  BoatsKit
//  © 2017 @toddheasley
//

import Foundation

public struct Provider {
    public var name: String = ""
    public var uri: URI = ""
    public var routes: [Route] = []
    public var url: URL?
    
    public func route(uri: URI) -> Route? {
        for route in routes {
            if route.uri == uri {
                return route
            }
        }
        return nil
    }
}

extension Provider: Codable {
    private enum Key: CodingKey {
        case name
        case uri
        case routes
        case url
    }
    
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encode(name, forKey: .name)
        try container.encode(uri, forKey: .uri)
        try container.encode(routes, forKey: .routes)
        if let url: URL = url {
            try container.encode(url, forKey: .url)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Key> = try decoder.container(keyedBy: Key.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.uri =  try container.decode(URI.self, forKey: .uri)
        self.routes = try container.decode(Array<Route>.self, forKey: .routes)
        self.url = try? container.decode(URL.self, forKey: .url)
    }
}

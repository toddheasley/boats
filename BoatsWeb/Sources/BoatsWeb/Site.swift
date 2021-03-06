import Foundation
import BoatsKit

public struct Site {
    public static let name: String = "Boats"
    public static let appIdentifier: String? = "1152562893"
    
    public static var appURL: URL? {
        guard let appIdentifier: String = appIdentifier, !appIdentifier.isEmpty else {
            return nil
        }
        return URL(string: "https://itunes.apple.com/us/app/id\(appIdentifier)")
    }
    
    public let index: Index
    
    public init(index: Index) {
        self.index = index
    }
}

extension Site: Resource {
    public var path: String {
        return index.path
    }
    
    public func build(to url: URL) throws {
        try? delete(from: url)
        var manifest: Manifest = Manifest()
        manifest.paths = [
            BookmarkIcon().path,
            Stylesheet().path,
            IndexView(index: index).path
        ]
        try BookmarkIcon().build(to: url)
        try Stylesheet().build(to: url)
        try IndexView(index: index).build(to: url)
        for route in index.routes {
            manifest.paths.insert(RouteView(route: route, index: index).path)
            try RouteView(route: route, index: index).build(to: url)
        }
        try manifest.build(to: url)
    }
    
    public func delete(from url: URL) throws {
        let manifest: Manifest = try Manifest(data: try Data(contentsOf: url.appendingPathComponent(Manifest().path)))
        for path in manifest.paths {
            try url.appendingPathComponent(path).delete()
        }
        try manifest.delete(from: url)
    }
    
    public func data() throws -> Data {
        return try index.data()
    }
}

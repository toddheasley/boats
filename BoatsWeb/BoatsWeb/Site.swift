import Foundation
import BoatsKit

struct Site {
    public let name: String = "Boats"
    public let appIdentifier: String = "1152562893"
    public private(set) var index: Index
    
    public var appURL: URL {
        return URL(string: "https://itunes.apple.com/us/app/id\(appIdentifier)")!
    }
    
    public init(index: Index) {
        self.index = index
    }
}

extension Site: Resource {
    
    var path: String {
        return index.path
    }
    
    public func build(to url: URL) throws {
        try? delete(from: url)
        var manifest: Manifest = Manifest()
        manifest.paths = [
            BookmarkIcon().path,
            Script().path,
            Stylesheet().path,
            IndexView(index: index).path
        ]
        try BookmarkIcon().build(to: url)
        try Script().build(to: url)
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
    
    func data() throws -> Data {
        return try index.data()
    }
}

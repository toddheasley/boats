import Foundation
import Boats

public struct Site: CustomStringConvertible {
    public static let name: String = "Boats"
    public static let baseURL: URL = URL(string: "https://toddheasley.github.io/boats/")!
    public static let repoURL: URL = URL(string: "https://github.com/toddheasley/boats")!
    public static let appIdentifier: String? = "1152562893"
    
    public static var appURL: URL? {
        guard let appIdentifier: String = appIdentifier, !appIdentifier.isEmpty else {
            return nil
        }
        return URL(string: "https://apps.apple.com/app/id\(appIdentifier)")
    }
    
    public let index: Index
    
    public init(_ index: Index = Index()) {
        self.index = index
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        return "\(index.name) \(index.description)"
    }
}

extension Site: Resource {
    public var path: String {
        return IndexView(index).path
    }
    
    public func build(to url: URL) throws {
        try? delete(from: url)
        let resources: [Resource] = [
            BookmarkIcon(),
            Favicon(),
            ShareImage(),
            IndexView(index)
        ]
        var manifest: Manifest = Manifest()
        for resource in resources {
            manifest.paths.insert(resource.path)
            try resource.build(to: url)
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

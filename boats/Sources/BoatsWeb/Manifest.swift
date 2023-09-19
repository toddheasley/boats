import Foundation
import Boats

struct Manifest: Resource {
    var paths: Set<String> = []
    
    public init(url: URL) throws {
        try self.init(data: try Data(contentsOf: url.appendingPathComponent(Manifest().path)))
    }
    
    public init(data: Data) throws {
        guard let manifest: String = String(data: data, encoding: .utf8), manifest.contains("CACHE MANIFEST\n") else {
            throw CocoaError(.fileReadUnknownStringEncoding)
        }
        let components: [String] = manifest.replacingOccurrences(of: "CACHE MANIFEST\n", with: "").components(separatedBy: "\n")
        for path in components {
            guard !path.isEmpty else {
                continue
            }
            paths.insert(path)
        }
    }
    
    public init() {
        
    }
    
    // MARK: Resource
    public let path: String = "manifest.appcache"
    
    public func data() throws -> Data {
        guard let data: Data = "CACHE MANIFEST\n\(paths.joined(separator: "\n"))".data(using: .utf8) else {
            throw CocoaError(.fileReadUnknownStringEncoding)
        }
        return data
    }
}

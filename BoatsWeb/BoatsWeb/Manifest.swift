import Foundation
import BoatsKit

struct Manifest {
    var paths: Set<String> = []
    
    public init() {
        
    }
}

extension Manifest: Resource {
    public init(data: Data) throws {
        guard let manifest: String = String(data: data, encoding: .utf8), manifest.contains("CACHE MANIFEST\n") else {
            throw(NSError(domain: NSCocoaErrorDomain, code: NSFileReadUnknownStringEncodingError))
        }
        let components: [String] = manifest.replacingOccurrences(of: "CACHE MANIFEST\n", with: "").components(separatedBy: "\n")
        for path in components {
            guard !path.isEmpty else {
                continue
            }
            paths.insert(path)
        }
    }
    
    // MARK: Resource
    public var path: String {
        return "manifest.appcache"
    }
    
    public func data() throws -> Data {
        guard let data: Data = "CACHE MANIFEST\n\(paths.joined(separator: "\n"))".data(using: .utf8) else {
            throw(NSError(domain: NSCocoaErrorDomain, code: NSFileReadUnknownStringEncodingError))
        }
        return data
    }
}

import Foundation

public protocol Resource {
    var path: String { get }
    
    func build(to url: URL) throws
    func delete(from url: URL) throws
    func data() throws -> Data
}

extension Resource {
    public func build(to url: URL) throws {
        try data().write(to: try URL(directory: url.path).appendingPathComponent(path))
    }
    
    public func delete(from url: URL) throws {
        try URL(directory: url.path).appendingPathComponent(path).delete()
    }
}

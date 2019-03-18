import Foundation
import BoatsKit

extension Resource {
    public func build(to url: URL) throws {
        try data().write(to: try URL(directory: url.path).appendingPathComponent(path))
    }
    
    public func delete(from url: URL) throws {
        try URL(directory: url.path).appendingPathComponent(path).delete()
    }
}

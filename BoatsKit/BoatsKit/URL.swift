//
//  BoatsKit
//  © 2017 @toddheasley
//

import Foundation

extension URL {
    public var directory: URL {
        return hasDirectoryPath ? self : deletingLastPathComponent()
    }
    
    public func appending(uri: URI) -> URL {
        return directory.appendingPathComponent("\(uri.resource)")
    }
    
    mutating public func append(uri: URI) {
        self = directory
        appendPathComponent("\(uri.resource)")
    }
}

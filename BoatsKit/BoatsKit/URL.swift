//
//  BoatsKit
//  © 2017 @toddheasley
//

import Foundation

public protocol URLReading {
    static func read(from url: URL, completion: @escaping (Self?, Error?) -> Void)
}

public protocol URLDeleting {
    func delete(from url: URL, completion: @escaping (Error?) -> Void)
}

public protocol URLWriting {
    func write(to url: URL, completion: @escaping (Error?) -> Void)
}

extension URL {
    public init(base url: URL, uri: URI, type: String = "") {
        var url: URL = url
        if !url.hasDirectoryPath {
            url.deleteLastPathComponent()
        }
        self = url.appendingPathComponent("\(uri)\(!type.isEmpty ? ".\(type)" : "")")
    }
}

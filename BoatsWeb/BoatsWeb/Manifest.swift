//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

struct Manifest {
    var uris: Set<URI> = []
}

extension Manifest: URIResource {
    var uri: URI {
        return URI(stringLiteral: "manifest", type: "appcache")
    }
}

extension Manifest: DataCoding {
    func data() throws -> Data {
        guard let data: Data = "CACHE MANIFEST\n\(uris.map { uri in uri.path }.joined(separator: "\n"))\n".data(using: .utf8) else {
            throw NSError(domain: NSCocoaErrorDomain, code: 0, userInfo: nil)
        }
        return data
    }
    
    init(data: Data) throws {
        guard let paths: [String] = String(data: data, encoding: .utf8)?.components(separatedBy: "\n"), paths.first == "CACHE MANIFEST" else {
            throw NSError(domain: NSCocoaErrorDomain, code: NSFileReadCorruptFileError, userInfo: nil)
        }
        self.uris = Set(paths.filter { path in
            path != "CACHE MANIFEST" && !path.isEmpty
        }.map { path in
            URI(path: path)
        })
    }
}

extension Manifest: URLReading, URLWriting {
    static func read(from url: URL, completion: @escaping (Manifest?, Error?) -> Void) {
        let url: URL = URL(base: url, uri: Manifest().uri, type: Manifest().uri.type)
        switch url.scheme ?? "" {
        case "file":
            do {
                let data: Data = try Data(contentsOf: url)
                completion(try Manifest(data: data), nil)
            } catch let error {
                completion(nil, error)
            }
        default:
            completion(nil, NSError(domain: NSURLErrorDomain, code: NSURLErrorUnsupportedURL, userInfo: nil))
        }
    }
}

//
// © 2017 @toddheasley
//

import Foundation
import BoatsKit

struct Manifest {
    var uris: Set<URI> = []
    
    public init() {
        
    }
}

extension Manifest: DataCoding {
    
    // MARK: DataCoding
    func data() throws -> Data {
        let components: [String] = ["CACHE MANIFEST"] + uris.map { uri in
            uri.resource
        }
        guard let data: Data = components.joined(separator: "\n").data(using: .utf8) else {
            throw NSError(domain: NSCocoaErrorDomain, code: NSFileWriteUnknownError, userInfo: nil)
        }
        return data
    }
    
    init(data: Data) throws {
        guard let components: [String] = String(data: data, encoding: .utf8)?.components(separatedBy: "\n"), components.first == "CACHE MANIFEST" else {
            throw NSError(domain: NSCocoaErrorDomain, code: NSFileReadCorruptFileError, userInfo: nil)
        }
        self.uris = Set(components.filter { component in
            component != "CACHE MANIFEST" && !component.isEmpty
        }.map { component in
            URI(stringLiteral: component)
        })
    }
}

extension Manifest: DataResource, DataReading, DataWriting {
    
    // MARK: DataResource
    public var uri: URI {
        return URI(resource: "manifest", type: "appcache")
    }
    
    // MARK: DataReading
    public static func read(from url: URL, completion: @escaping (Manifest?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url.appending(uri: Manifest().uri)) { data, response, error in
            DispatchQueue.main.async {
                guard let data: Data = data else {
                    completion(nil, error ?? NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil))
                    return
                }
                do {
                    completion(try Manifest(data: data), nil)
                } catch let error {
                    completion(nil, error)
                }
            }
            }.resume()
    }
    
    public init(url: URL) throws {
        try self.init(data: try Data(contentsOf: url.appending(uri: Manifest().uri)))
    }
}

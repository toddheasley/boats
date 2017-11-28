//
// © 2017 @toddheasley
//

import Foundation

public struct Index: Codable {
    public var name: String = ""
    public var description: String = ""
    public var localization: Localization = Localization()
    public var providers: [Provider] = []
    
    public func provider(uri: URI) -> Provider? {
        for provider in providers {
            if provider.uri == uri {
                return provider
            }
        }
        return nil
    }
    
    public func provider(at index: Int) -> Provider? {
        guard index >= 0, index < providers.count else {
            return nil
        }
        return providers[index]
    }
    
    public init() {
        
    }
}

extension Index: DataCoding {
    
}

extension Index: DataResource, DataReading, DataWriting {
    
    // MARK: DataResource
    public var uri: URI {
        return URI(resource: "index", type: "json")
    }
    
    // MARK: DataReading
    public static func read(from url: URL, completion: @escaping (Index?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url.appending(uri: Index().uri)) { data, response, error in
            DispatchQueue.main.async {
                guard let data: Data = data else {
                    completion(nil, error ?? NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil))
                    return
                }
                do {
                    completion(try Index(data: data), nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
    public init(url: URL) throws {
        try self.init(data: try Data(contentsOf: url.appending(uri: Index().uri)))
    }
}

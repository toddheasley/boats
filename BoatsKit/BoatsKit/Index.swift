//
//  BoatsKit
//  © 2017 @toddheasley
//

import Foundation

public struct Index: URIResource, Codable {
    public var name: String = ""
    public var description: String = ""
    public var localization: Localization = Localization()
    public var providers: [Provider] = []
    
    public var uri: URI {
        return "index"
    }
    
    public func provider(uri: URI) -> Provider? {
        for provider in providers {
            if provider.uri == uri {
                return provider
            }
        }
        return nil
    }
}

extension Index: DataCoding {
    public func data() throws -> Data {
        return try JSON.encoder.encode(self)
    }
    
    public init(data: Data) throws {
        self = try JSON.decoder.decode(Index.self, from: data)
    }
}

extension Index: URLReading, URLWriting {
    public static func read(from url: URL, completion: @escaping (Index?, Error?) -> Void) {
        let url: URL = URL(base: url, uri: Index().uri, type: "json")
        switch url.scheme ?? "" {
        case "https":
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let data: Data = data else {
                        completion(nil, error ?? NSError(domain: NSCocoaErrorDomain, code: NSFileReadUnknownError, userInfo: nil))
                        return
                    }
                    do {
                        completion(try Index(data: data), nil)
                    } catch let error {
                        completion(nil, error)
                    }
                }
            }
        case "file":
            do {
                let data: Data = try Data(contentsOf: url)
                completion(try Index(data: data), nil)
            } catch let error {
                completion(nil, error)
            }
        default:
            completion(nil, NSError(domain: NSURLErrorDomain, code: NSURLErrorUnsupportedURL, userInfo: nil))
        }
    }
    
    public func write(to url: URL, completion: @escaping (Error?) -> Void) {
        let url: URL = URL(base: url, uri: Index().uri, type: "json")
        switch url.scheme ?? "" {
        case "file":
            do {
                try data().write(to: url, options: Data.WritingOptions.atomic)
                completion(nil)
            } catch let error {
                completion(error)
            }
        default:
            completion(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnsupportedURL, userInfo: nil))
        }
    }
}

//
//  BoatsKit
//  © 2017 @toddheasley
//

import Foundation

public struct Index: Codable {
    public var name: String = ""
    public var description: String = ""
    public var localization: Localization = Localization()
    public var providers: [Provider] = []
}

extension Index {
    public static func read(from url: URL, completion: @escaping (Index?, Error?) -> Void) {
        switch url.scheme ?? "" {
        case "https":
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let data: Data = data else {
                        completion(nil, error ?? NSError(domain: NSCocoaErrorDomain, code: NSFileReadUnknownError, userInfo: nil))
                        return
                    }
                    do {
                        completion(try JSON.decoder.decode(Index.self, from: data), nil)
                    } catch let error {
                        completion(nil, error)
                    }
                }
            }
        case "file":
            do {
                let data: Data = try Data(contentsOf: url)
                completion(try JSON.decoder.decode(Index.self, from: data), nil)
            } catch let error {
                completion(nil, error)
            }
        default:
            completion(nil, NSError(domain: NSURLErrorDomain, code: NSURLErrorUnsupportedURL, userInfo: nil))
        }
    }
    
    public func write(to url: URL, prettyPrinted: Bool = false, completion: (Error?) -> Void) {
        if prettyPrinted {
            JSON.encoder.outputFormatting = .prettyPrinted
        }
        switch url.scheme ?? "" {
        case "file":
            do {
                try JSON.encoder.encode(self).write(to: url, options: Data.WritingOptions.atomic)
                completion(nil)
            } catch let error {
                completion(error)
            }
        default:
            completion(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnsupportedURL, userInfo: nil))
        }
    }
}

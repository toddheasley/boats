//
//  BoatsKit
//  © 2017 @toddheasley
//

import Foundation

public struct Boats: Codable {
    public var name: String = ""
    public var description: String = ""
    public var providers: [Provider] = []
    public var timeZone: TimeZone = .current
}

extension Boats {
    public var data: Data {
        return try! JSONEncoder().encode(self)
    }
    
    public init?(data: Data) {
        guard let boats = try? JSONDecoder().decode(Boats.self, from: data) else {
            return nil
        }
        self = boats
    }
}

extension Boats {
    public static func read(from url: URL, completion: @escaping (Boats?, Error?) -> Void) {
        switch url.scheme ?? "" {
        case "http", "https":
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data else {
                        completion(nil, error ?? NSError(domain: NSCocoaErrorDomain, code: NSFileReadUnknownError, userInfo: nil))
                        return
                    }
                    do {
                        completion(try JSONDecoder().decode(Boats.self, from: data), nil)
                    } catch let error {
                        completion(nil, error)
                    }
                }
            }
        case "file":
            do {
                let data: Data = try Data(contentsOf: url)
                completion(try JSONDecoder().decode(Boats.self, from: data), nil)
            } catch let error {
                completion(nil, error)
            }
        default:
            completion(nil, NSError(domain: NSURLErrorDomain, code: NSURLErrorUnsupportedURL, userInfo: nil))
        }
    }
    
    public func write(to url: URL, completion: (Error?) -> Void) {
        guard url.scheme == "file" else {
            completion(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnsupportedURL, userInfo: nil))
            return
        }
        do {
            try data.write(to: url, options: Data.WritingOptions.atomic)
        } catch let error {
            completion(error)
        }
    }
}

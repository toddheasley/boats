//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

public struct Site {
    public static var name: String = "Boats"
    public static var appIdentifier: String?
    public private(set) var index: Index
    
    public init(index: Index) {
        self.index = index
    }
}

extension Site: URLWriting {
    public func write(to url: URL, completion: @escaping (Error?) -> Void) {
        remove(from: url) { error in
            if let error = error {
                completion(error)
                return
            }
            let manifest: Manifest = Manifest()
            IndexView(index: self.index).document.write(to: url, completion: completion)
            for provider in self.index.providers {
                for route in provider.routes {
                    RouteView(index: self.index, provider: provider, route: route).document.write(to: url, completion: completion)
                }
            }
            Stylesheet().write(to: url, completion: completion)
            BookmarkIcon().write(to: url, completion: completion)
            manifest.write(to: url, completion: completion)
        }
    }
    
    public func remove(from url: URL, completion: @escaping (Error?) -> Void) {
        Manifest.read(from: url) { manifest, error in
            guard let manifest = manifest else {
                completion(error)
                return
            }
            for uri in manifest.uris + [manifest.uri] {
                do {
                    try FileManager.default.removeItem(at: URL(base: url, uri: uri))
                } catch let error {
                    completion(error)
                    return
                }
            }
            completion(nil)
        }
    }
}

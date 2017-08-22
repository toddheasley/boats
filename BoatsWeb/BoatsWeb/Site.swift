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

extension Site: URLWriting, URLDeleting {
    public func write(to url: URL, completion: @escaping (Error?) -> Void) {
        let handler: (Error?) -> Void = { error in
            if let error = error {
                completion(error)
                return
            }
        }
        
        delete(from: url) { error in
            if let error = error {
                completion(error)
                return
            }
            var manifest: Manifest = Manifest()
            let document: HTMLDocument = IndexView(index: self.index).document
            document.write(to: url, completion: handler)
            manifest.uris.insert(document.uri)
            for provider in self.index.providers {
                for route in provider.routes {
                    let document: HTMLDocument = RouteView(index: self.index, provider: provider, route: route).document
                    document.write(to: url, completion: handler)
                    manifest.uris.insert(document.uri)
                }
            }
            Stylesheet().write(to: url, completion: handler)
            manifest.uris.insert(Stylesheet().uri)
            BookmarkIcon().write(to: url, completion: handler)
            manifest.uris.insert(BookmarkIcon().uri)
            manifest.write(to: url, completion: completion)
        }
    }
    
    public func delete(from url: URL, completion: @escaping (Error?) -> Void) {
        Manifest.read(from: url) { manifest, _ in
            guard let manifest = manifest else {
                completion(nil)
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

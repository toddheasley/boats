//
//  BoatsEdit
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit
import BoatsWeb

struct IndexManager {
    private(set) static var index: Index?
    
    static var url: URL? {
        set {
            UserDefaults.standard.set(newValue, forKey: "url")
            index = nil
        }
        get {
            return UserDefaults.standard.url(forKey: "url")
        }
    }
    
    static var web: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "web")
            
        }
        get {
            return UserDefaults.standard.bool(forKey: "web")
        }
    }
    
    /*
    static func canOpen(from url: URL) -> Bool {
        let uri: URI = URI(stringLiteral: "\(Index().uri)", type: "json")
        if url.lastPathComponent == uri.path {
            return true
        } else if url.hasDirectoryPath {
            return FileManager.default.fileExists(atPath: url.appendingPathComponent(uri.path).path)
        }
        return false
    }
    
    static func open(from url: URL? = nil, completion: ((Error?) -> Void)? = nil) {
        guard let url: URL = url else {
            if let url: URL = self.url {
                self.open(from: url, completion: completion)
            } else {
                completion?(nil)
            }
            return
        }
        close()
        self.url = url
        Index.read(from: url) { index, error in
            guard let index: Index = index else {
                self.url = nil
                completion?(error ?? NSError(domain: NSCocoaErrorDomain, code: NSFileReadUnknownError, userInfo: nil))
                return
            }
            self.index = index
            completion?(nil)
        }
    }
    
    static func make(at url: URL, completion: ((Error?) -> Void)? = nil) {
        close()
        self.open(from: url) { error in
            guard let _: Error = error else {
                completion?(nil)
                return
            }
            self.url = url
            Index().write(to: url) { error in
                
                completion?(self.index == nil ? error : nil)
            }
        }
    }
    
    static func save(completion: ((Error?) -> Void)? = nil) {
        guard let url: URL = url,
            let index: Index = index else {
                completion?(NSError(domain: NSCocoaErrorDomain, code: NSFileWriteUnknownError, userInfo: nil))
                return
        }
        index.write(to: url, web: web) { error in
            completion?(error)
        }
    }
    
    static func close() {
        url = nil
        index = nil
    }
    */
}

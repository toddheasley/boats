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
    
    static func canOpen(from url: URL) -> Bool {
        if url.lastPathComponent == Index().uri.resource {
            return true
        } else if url.hasDirectoryPath {
            return FileManager.default.fileExists(atPath: url.appending(uri: Index().uri).path)
        }
        return false
    }
    
    static func open(from url: URL? = url) throws {
        guard let url: URL = url?.directory else {
            self.url = nil
            return
        }
        self.url = url
        self.index = try Index(url: url)
    }
    
    static func make(at url: URL) throws {
        do {
            try open(from: url)
        } catch {
            self.url = url.directory
            try Index().write(to: url)
        }
    }
    
    static func save() throws {
        guard let url: URL = url,
            let index: Index = index else {
            throw NSError(domain: NSURLErrorDomain, code: NSURLErrorFileDoesNotExist, userInfo: nil)
        }
        try index.write(to: url)
    }
}

import Foundation
import BoatsKit
import BoatsWeb

struct IndexManager {
    private(set) static var index: Index?
    
    static var url: URL? {
        set {
            UserDefaults.standard.set(newValue, forKey: "URL")
            index = nil
        }
        get {
            return UserDefaults.standard.url(forKey: "URL")
        }
    }
    
    static var web: Bool {
        set {
            guard let url: URL = url else {
                return
            }
            try? index?.write(to: url, web: newValue)
        }
        get {
            guard let url: URL = url else {
                return false
            }
            return FileManager.default.fileExists(atPath: url.appending(uri: Site.uri).path)
        }
    }
    
    static func canOpen(from url: URL) -> Bool {
        return url.lastPathComponent == Index().uri.resource && FileManager.default.fileExists(atPath: url.path)
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
            try Index().write(to: url, web: web)
            try open(from: url)
        }
    }
    
    static func save(index: Index?) throws {
        guard let url: URL = url,
            let index: Index = index else {
            throw NSError(domain: NSURLErrorDomain, code: NSURLErrorFileDoesNotExist, userInfo: nil)
        }
        try index.write(to: url, web: web)
    }
}

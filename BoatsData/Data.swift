//
//  Data.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public final class Data {
    private let URL: NSURL = NSURL(string: "https://toddheasley.github.io/boats/data.json")!
    public static let sharedData: Data = Data()
    public private(set) var providers: [Provider] = []
    
    public func provider(code: String) -> Provider? {
        for provider in providers {
            if (code == provider.code) {
                return provider
            }
        }
        return nil
    }
    
    public func reloadData(completion: ((Bool) -> Void)?) {
        NSURLSession.sharedSession().dataTaskWithURL(URL) { data, response, error in
            guard let data = data, JSON = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) where self.refresh(JSON) else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion?(false)
                }
                return
            }
            NSUserDefaults.standardUserDefaults().data = data
            dispatch_async(dispatch_get_main_queue()){
                completion?(true)
            }
        }.resume()
    }
    
    public init() {
        if let data = NSUserDefaults.standardUserDefaults().data, JSON = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) {
            refresh(JSON)
        }
    }
}

extension Data: JSONEncoding, JSONDecoding {
    private func refresh(JSON: AnyObject) -> Bool {
        guard let JSON = JSON as? [String: AnyObject], providers = JSON["providers"] as? [AnyObject] else {
            return false
        }
        self.providers = []
        for providerJSON in providers {
            guard let provider = Provider(JSON: providerJSON) else {
                return false
            }
            self.providers.append(provider)
        }
        return true
    }
    
    var JSON: AnyObject {
        return [
            "providers": providers.map{$0.JSON}
        ]
    }
    
    convenience init?(JSON: AnyObject) {
        self.init()
        if (!refresh(JSON)) {
            return nil
        }
    }
}

extension NSUserDefaults {
    var data: NSData? {
        set {
            setObject(newValue, forKey: "data")
            synchronize()
        }
        get {
            return objectForKey("data") as? NSData
        }
    }
}

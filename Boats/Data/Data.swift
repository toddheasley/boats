//
//  Data.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import Foundation

class Data: JSONEncoding {
    static let sharedData = Data()
    private(set) var local: Bool = false
    private(set) var providers: [Provider] = []
    
    func provider(code: String) -> Provider? {
        for provider in providers {
            if (code == provider.code) {
                return provider
            }
        }
        return nil
    }
    
    func refresh(completion: (error: Error) -> Void) {
        var URL: NSURL? =  NSURL(string: "https://raw.githubusercontent.com/toddheasley/boats/master/data.json")
        if (local) {
            guard let path = NSBundle.mainBundle().pathForResource("data", ofType: "json") else {
                completion(error: .URL)
                return
            }
            URL = NSURL.fileURLWithPath(path)
        }
        guard let _ = URL else {
            completion(error: .URL)
            return
        }
        NSURLSession.sharedSession().dataTaskWithURL(URL!){ data, response, error in
            if let _ = error {
                completion(error: .HTTP)
                return
            }
            if (!self.local) {
                guard let response = response as? NSHTTPURLResponse where response.statusCode == 200 else {
                    completion(error: .HTTP)
                    return
                }
            }
            guard let data = data else {
                completion(error: .HTTP)
                return
            }
            do {
                guard let JSON = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String: AnyObject], let _ = JSON["providers"] as? [AnyObject] else {
                    completion(error: .JSONDecoding)
                    return
                }
                var providers: [Provider] = []
                for providerJSON in (JSON["providers"] as! [AnyObject]) {
                    guard let provider = Provider(JSON: providerJSON) else {
                        completion(error: .JSONDecoding)
                        return
                    }
                    providers.append(provider)
                }
                self.providers = providers
                completion(error: .None)
            } catch  {
                completion(error: .JSONDecoding)
            }
        }.resume()
    }
    
    convenience init(local: Bool) {
        self.init()
        self.local = local
    }
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return [
            "providers": providers.map{$0.JSON}
        ]
    }
}

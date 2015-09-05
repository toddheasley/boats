//
//  Data.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import Foundation

class Data: JSONEncoding {
    static let sharedData = Data()
    private(set) var routes: [Route] = []
    private(set) var local: Bool = false
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return [
            "routes": routes.map{$0.JSON}
        ]
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
                guard let JSON = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String: AnyObject], let _ = JSON["routes"] as? [AnyObject] else {
                    completion(error: .JSONDecoding)
                    return
                }
                var routes: [Route] = []
                for routeJSON in (JSON["routes"] as! [AnyObject]) {
                    guard let route = Route(JSON: routeJSON) else {
                        completion(error: .JSONDecoding)
                        return
                    }
                    routes.append(route)
                }
                self.routes = routes
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
}

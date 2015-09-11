//
//  Provider.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import Foundation

struct Provider: JSONDecoding, JSONEncoding {
    private(set) var name: String
    private(set) var code: String
    private(set) var www: String
    private(set) var routes: [Route]
    
    func route(code: String) -> Route? {
        for route in routes {
            if (code == route.code) {
                return route
            }
        }
        return nil
    }
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return [
            "name": name,
            "code": code,
            "www": www,
            "routes": routes.map{$0.JSON}
        ]
    }
    
    // MARK JSONDecoding
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? [String: AnyObject], let name = JSON["name"] as? String, let code = JSON["code"] as? String, let www = JSON["www"] as? String, let _ = JSON["routes"] as? [AnyObject] else {
            return nil
        }
        self.name = name
        self.code = code
        self.www = www
        var routes: [Route] = []
        for routeJSON in (JSON["routes"] as! [AnyObject]) {
            guard let route = Route(JSON: routeJSON) else {
                return nil
            }
            routes.append(route)
        }
        self.routes = routes
    }
}

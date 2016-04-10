//
//  Provider.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public struct Provider {
    public private(set) var name: String
    public private(set) var code: String
    public private(set) var www: String
    public private(set) var routes: [Route]
    
    public func route(code: String) -> Route? {
        for route in routes {
            if (code == route.code) {
                return route
            }
        }
        return nil
    }
}

extension Provider: JSONEncoding, JSONDecoding {
    var JSON: AnyObject {
        return [
            "name": name,
            "code": code,
            "www": www,
            "routes": routes.map{$0.JSON}
        ]
    }
    
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? [String: AnyObject], name = JSON["name"] as? String, code = JSON["code"] as? String, www = JSON["www"] as? String, _ = JSON["routes"] as? [AnyObject] else {
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

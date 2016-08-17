//
//  Provider.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public struct Provider {
    public internal(set) var name: String
    public internal(set) var code: String
    public internal(set) var www: String
    public internal(set) var routes: [Route]
    
    public func route(code: String) -> Route? {
        for route in routes {
            if code == route.code {
                return route
            }
        }
        return nil
    }
}

extension Provider: JSONEncoding, JSONDecoding {
    var JSON: Any {
        return [
            "name": name,
            "code": code,
            "www": www,
            "routes": routes.map { $0.JSON }
        ]
    }
    
    init?(JSON: Any) {
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

//
//  Location.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public struct Location {
    public private(set) var name: String
    public private(set) var description: String
    public private(set) var coordinate: Coordinate
}

extension Location: JSONEncoding, JSONDecoding {
    var JSON: AnyObject {
        return [
            "name": name,
            "description": description,
            "coordinate": coordinate.JSON
        ]
    }
    
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? [String: AnyObject], name = JSON["name"] as? String, description = JSON["description"] as? String, _ = JSON["coordinate"] as? String, coordinate = Coordinate(JSON: JSON["coordinate"]!) else {
            return nil
        }
        self.name = name
        self.description = description
        self.coordinate = coordinate
    }
}
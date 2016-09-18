//
//  Location.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public struct Location {
    public fileprivate(set) var name: String
    public fileprivate(set) var description: String
    public fileprivate(set) var coordinate: Coordinate
}

extension Location: JSONEncoding, JSONDecoding {
    var JSON: Any {
        return [
            "name": name,
            "description": description,
            "coordinate": coordinate.JSON
        ]
    }
    
    init?(JSON: Any) {
        guard let JSON = JSON as? [String: AnyObject], let name = JSON["name"] as? String, let description = JSON["description"] as? String, let _ = JSON["coordinate"] as? String, let coordinate = Coordinate(JSON: JSON["coordinate"]!) else {
            return nil
        }
        self.name = name
        self.description = description
        self.coordinate = coordinate
    }
}

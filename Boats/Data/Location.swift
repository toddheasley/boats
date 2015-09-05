//
//  Location.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import Foundation

struct Location: JSONDecoding, JSONEncoding {
    private(set) var name: String
    private(set) var description: String
    private(set) var coordinate: Coordinate
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return [
            "name": name,
            "description": description,
            "coordinate": coordinate.JSON
        ]
    }
    
    // MARK: JSONDecoding
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? [String: AnyObject], let name = JSON["name"] as? String, let description = JSON["description"] as? String, let _ = JSON["coordinate"] as? String, let coordinate = Coordinate(JSON: JSON["coordinate"]!) else {
            return nil
        }
        self.name = name
        self.description = description
        self.coordinate = coordinate
    }
}

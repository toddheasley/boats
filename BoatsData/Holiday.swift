//
//  Holiday.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public struct Holiday {
    public internal(set) var name: String
    public internal(set) var date: Date
}

extension Holiday: JSONEncoding, JSONDecoding {
    var JSON: Any {
        return [
            "name": name,
            "date": date.JSON
        ]
    }
    
    init?(JSON: Any) {
        guard let JSON = JSON as? [String: AnyObject], let name = JSON["name"] as? String, let _ = JSON["date"] as? String, let date = Date(JSON: JSON["date"]!) else {
            return nil
        }
        self.name = name
        self.date = date
    }
}

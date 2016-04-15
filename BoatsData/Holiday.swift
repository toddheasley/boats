//
//  Holiday.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public struct Holiday {
    public private(set) var name: String
    public private(set) var date: Date
}

extension Holiday: JSONEncoding, JSONDecoding {
    var JSON: AnyObject {
        return [
            "name": name,
            "date": date.JSON
        ]
    }
    
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? [String: AnyObject], name = JSON["name"] as? String, _ = JSON["date"] as? String, date = Date(JSON: JSON["date"]!) else {
            return nil
        }
        self.name = name
        self.date = date
    }
}

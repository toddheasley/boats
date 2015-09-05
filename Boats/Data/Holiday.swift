//
//  Holiday.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import Foundation

struct Holiday: JSONDecoding, JSONEncoding {
    private(set) var name: String
    private(set) var date: Date
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return [
            "name": name,
            "date": date.JSON
        ]
    }
    
    // MARK JSONDecoding
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? [String: AnyObject], let name = JSON["name"] as? String, _ = JSON["date"] as? String, let date = Date(JSON: JSON["date"]!) else {
            return nil
        }
        self.name = name
        self.date = date
    }
}

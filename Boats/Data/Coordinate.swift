//
//  Coordinate.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import Foundation

struct Coordinate: JSONDecoding, JSONEncoding {
    private(set) var latitude: Double
    private(set) var longitude: Double
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return "\(latitude),\(longitude)"
    }
    
    // MARK JSONDecoding
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? String else {
            return nil
        }
        let components = JSON.characters.split{$0 == ","}.map{String($0)}
        if (components.count != 2) {
            return nil
        }
        guard let latitude = Double(components[0]), let longitude = Double(components[1]) where !latitude.isNaN && !longitude.isNaN else {
            return nil
        }
        self.latitude = latitude
        self.longitude = longitude
    }
}

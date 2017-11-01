//
//  Coordinate.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public struct Coordinate {
    public fileprivate(set) var latitude: Double
    public fileprivate(set) var longitude: Double
}

extension Coordinate: JSONEncoding, JSONDecoding {
    var JSON: Any {
        return "\(latitude),\(longitude)"
    }
    
    init?(JSON: Any) {
        guard let JSON = JSON as? String else {
            return nil
        }
        let components = JSON.split { $0 == "," }.map { String($0) }
        if components.count != 2 {
            return nil
        }
        guard let latitude = Double(components[0]), let longitude = Double(components[1]), !latitude.isNaN && !longitude.isNaN else {
            return nil
        }
        self.latitude = latitude
        self.longitude = longitude
    }
}

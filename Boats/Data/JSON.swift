//
//  JSON.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import Foundation

protocol JSONDecoding {
    init?(JSON: AnyObject)
}

protocol JSONEncoding {
    var JSON: AnyObject {
        get
    }
}

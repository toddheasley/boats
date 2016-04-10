//
//  JSON.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

protocol JSONEncoding {
    var JSON: AnyObject {
        get
    }
}

protocol JSONDecoding {
    init?(JSON: AnyObject)
}

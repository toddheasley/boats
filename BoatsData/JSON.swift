//
//  JSON.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

protocol JSONEncoding {
    var JSON: Any {
        get
    }
}

protocol JSONDecoding {
    init?(JSON: Any)
}

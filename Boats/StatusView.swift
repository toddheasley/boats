//
//  Status.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

enum Status {
    case past, next, soon, last
}

protocol StatusView {
    var status: Status {
        set
        get
    }
}

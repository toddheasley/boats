//
//  Status.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

enum Status {
    case past, next, soon, last
    
    init() {
        self = .soon
    }
}

protocol StatusView {
    var status: Status {
        set
        get
    }
}

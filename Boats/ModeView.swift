//
//  ModeView.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

enum Mode {
    case day, night
    
    init() {
        self = UIScreen.main.brightness > 0.35 ? .day : .night
    }
}

protocol ModeView {
    var mode: Mode {
        set
        get
    }
}

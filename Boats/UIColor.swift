//
//  UIColor.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

extension UIColor {
    static func highlight(mode: Mode = Mode()) -> UIColor {
        return UIColor.foreground(mode: mode).withAlphaComponent(0.1)
    }
    
    static func tint(mode: Mode = Mode()) -> UIColor {
        switch mode {
        case .day:
            return UIColor(displayP3Red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        case .night:
            return .white
        }
    }
    
    static func foreground(mode: Mode = Mode()) -> UIColor {
        switch mode {
        case .day:
            return .darkText
        case .night:
            return .lightText
        }
    }
    
    static func background(mode: Mode = Mode()) -> UIColor {
        switch mode {
        case .day:
            return .white
        case .night:
            return UIColor(white: 0.15, alpha: 1.0)
        }
    }
}

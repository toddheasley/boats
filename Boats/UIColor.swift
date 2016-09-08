//
//  UIColor.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

extension UIColor {
    static func highlight(mode: Mode = Mode()) -> UIColor {
        switch mode {
        case .day:
            return UIColor.tint(mode: mode).withAlphaComponent(0.15)
        case .night:
            return UIColor.foreground(mode: mode).withAlphaComponent(0.15)
        }
    }
    
    static func tint(mode: Mode = Mode()) -> UIColor {
        switch mode {
        case .day:
            return UIColor(displayP3Red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        case .night:
            return .foreground(mode: mode)
        }
    }
    
    static func foreground(mode: Mode = Mode()) -> UIColor {
        switch mode {
        case .day:
            return .darkText
        case .night:
            return UIColor(white: 0.85, alpha: 1.0)
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

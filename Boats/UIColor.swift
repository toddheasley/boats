//
//  UIColor.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

extension UIColor {
    var highlight: UIColor {
        return withAlphaComponent(0.04)
    }
    
    static func control(mode: Mode = Mode()) ->UIColor {
        switch mode {
        case .day:
            return UIColor(displayP3Red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        case .night:
            return .lightGray
        }
    }
    
    static func foreground(mode: Mode = Mode(), status: Status = Status()) -> UIColor {
        switch mode {
        case .day:
            switch status {
            case .past:
                return UIColor.darkText.withAlphaComponent(0.4)
            case .soon, .next, .last:
                return UIColor.darkText.withAlphaComponent(0.9)
            }
        case .night:
            switch status {
            case .past:
                return UIColor.white.withAlphaComponent(0.3)
            case .soon, .last:
                return UIColor.white.withAlphaComponent(0.75)
            case .next:
                return .white
            }
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

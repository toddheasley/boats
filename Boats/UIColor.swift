//
//  UIColor.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

enum ColorMode {
    case day, night
}

extension UIColor {
    static var mode: ColorMode {
        return UIScreen.main.brightness > 0.35 ? .day : .night
    }
    
    static var statusBar: UIStatusBarStyle {
        return (mode == .night) ? .lightContent : .default
    }
    
    static var background: UIColor {
        switch mode {
        case .day:
            return UIColor.white
        case .night:
            return UIColor(white: 0.15, alpha: 1.0)
        }
    }
    
    static var foreground: UIColor {
        return foreground(status: .soon)
    }
    
    static var highlight: UIColor {
        return foreground.withAlphaComponent(0.05)
    }
    
    var disabled: UIColor {
        return withAlphaComponent(0.1)
    }
    
    static func foreground(status: Status) -> UIColor {
        switch mode {
        case .day:
            switch status {
            case .last:
                return UIColor(displayP3Red: 0.9, green: 0.23, blue: 0.19, alpha: 0.85)
            case .past:
                return UIColor(white: 0.15, alpha: 0.2)
            case .soon, .next:
                return UIColor(white: 0.15, alpha: 1.0)
            }
        case .night:
            switch status {
            case .last:
                return UIColor(displayP3Red: 1.0, green: 0.23, blue: 0.19, alpha: 0.9)
            case .next:
                return UIColor.white
            case .past:
                return UIColor(white: 0.8, alpha: 0.5)
            case .soon:
                return UIColor(white: 0.8, alpha: 1.0)
            }
        }
    }
}

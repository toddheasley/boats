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
    
    static var control: UIColor {
        switch mode {
        case .day:
            return UIColor(displayP3Red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0)
        case .night:
            return .lightGray
        }
    }
    
    static var background: UIColor {
        switch mode {
        case .day:
            return .white
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
            case .past:
                return UIColor.darkText.withAlphaComponent(0.4)
            case .soon, .next, .last:
                return .darkText
            }
        case .night:
            switch status {
            case .past:
                return UIColor.lightText.withAlphaComponent(0.35)
            case .soon, .last:
                return .lightText
            case .next:
                return .white
            }
        }
    }
}

//
//  UIColor.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

extension UIColor {
    private static var light: CGFloat {
        let date = Date()
        let time = Time()
        let peak = 765 - (abs(date.month - 7) * 10)
        let length = (920 - (abs(date.month - 7) * 64)) / 2
        let actual = (time.hour * 60) + time.minute
        let offset = length - abs(peak - actual)
        let light = max(min((CGFloat(offset) / CGFloat(length)) * 3.5, 1.0), 0.1)
        return (light > 0.25 && light < 0.75) ? 0.75 : light
    }
    
    static func alpha(status: Status = .future) -> CGFloat {
        return (status == .past) ? 0.4 : 1.0
    }
    
    static func background(status: Status) -> UIColor {
        switch status {
        case .next:
            return (light > 0.5) ? blue() : background(status: .future)
        case .last:
            return (light > 0.5) ? red() : background(status: .future)
        default:
            return UIColor(white: light, alpha: 1.0)
        }
    }
    
    static func foreground(season: Season) -> UIColor {
        switch season {
        case .spring:
            return UIColor.green()
        case .summer:
            return UIColor.purple()
        case .fall:
            return UIColor.brown()
        default:
            return UIColor.foreground
        }
    }
    
    static func foreground(status: Status) -> UIColor {
        switch status {
        case .last:
             return (light < 0.5) ? red() : foreground(status: .future)
        default:
            return UIColor(white: (light < 0.5) ? 0.9 : 0.1, alpha: alpha(status: status))
        }
    }
    
    static var background: UIColor {
        return background(status: .future)
    }
    
    static var foreground: UIColor {
        return foreground(status: .future)
    }
    
    static var highlight: UIColor {
        return foreground.withAlphaComponent(0.05)
    }
    
    static var none: UIColor {
        return .clear()
    }
    
    static var statusBar: UIStatusBarStyle {
        return (light < 0.5) ? .lightContent : .default
    }
    
    var disabled: UIColor {
        return withAlphaComponent(0.075)
    }
}

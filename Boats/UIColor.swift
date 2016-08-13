//
//  UIColor.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

extension UIColor {
    static var background: UIColor {
        return UIColor(light: light, alpha: 1.0)
    }
    
    static var foreground: UIColor {
        return foreground(status: .soon)
    }
    
    static var highlight: UIColor {
        return foreground.withAlphaComponent(0.05)
    }
    
    static var none: UIColor {
        return .clear
    }
    
    static var statusBar: UIStatusBarStyle {
        return (light < 0.5) ? .lightContent : .default
    }
    
    var disabled: UIColor {
        return withAlphaComponent(0.05)
    }
    
    static func foreground(status: Status) -> UIColor {
        switch status {
        case .next:
            return UIColor.white
        case .last:
            break
        default:
            break
        }
        return UIColor(light: (light < 0.5) ? 0.7 : 0.0, alpha: (status == .past) ? 0.21 : 1.0)
    }
    
    private convenience init(light: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: UIColor.shift(0.05, light: light), green: UIColor.shift(0.13, light: light), blue: UIColor.shift(0.21, light: light), alpha: alpha)
    }
    
    private static func shift(_ value: CGFloat, light: CGFloat) -> CGFloat {
        return min(max(value + (light * 0.7), 0.0), 1.0)
    }
    
    private static var light: CGFloat {
        let date = Date()
        let time = Time()
        let peak = 765 - (abs(date.month - 7) * 10)
        let length = (920 - (abs(date.month - 7) * 64)) / 2
        let actual = (time.hour * 60) + time.minute
        let offset = length - abs(peak - actual)
        let light = max(min((CGFloat(offset) / CGFloat(length)) * 3.5, 1.0), 0.1)
        return (light > 0.15 && light < 0.75) ? 0.75 : light
    }
}

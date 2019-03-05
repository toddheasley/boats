import UIKit

extension UIColor {
    static var background: UIColor {
        switch Appearance.current {
        case .light:
            return UIColor(white: 1.0, alpha: 1.0)
        default:
            return UIColor(white: 0.0, alpha: 1.0)
        }
    }
    
    static var color: UIColor {
        switch Appearance.current {
        case .light:
            return UIColor(white: 0.0, alpha: 1.0)
        default:
            return UIColor(white: 1.0, alpha: 1.0)
        }
    }
}

extension CGColor {
    static var background: CGColor {
        return UIColor.background.cgColor
    }
    
    static var color: CGColor {
        return UIColor.color.cgColor
    }
}

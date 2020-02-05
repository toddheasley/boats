import WatchKit

extension UIColor {
    static func foreground(highlighted: Bool = false) -> UIColor {
        switch highlighted {
        case true:
            return UIColor(white: 1.0, alpha: 1.0)
        default:
            return UIColor(white: 0.15, alpha: 1.0)
        }
    }
    
    static func label(highlighted: Bool = false) -> UIColor {
        switch highlighted {
        case true:
            return UIColor(white: 0.0, alpha: 1.0)
        default:
            return UIColor(white: 1.0, alpha: 1.0)
        }
    }
}

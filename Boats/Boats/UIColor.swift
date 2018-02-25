import UIKit

extension UIColor {
    static var background: UIColor {
        switch Mode.current {
        case .dark:
            return .black
        default:
            return .white
        }
    }
    
    static var text: UIColor {
        switch Mode.current {
        case .dark:
            return .white
        default:
            return .black
        }
    }
    
    static var tint: UIColor {
        return UIColor.text.withAlphaComponent(0.15)
    }
    
    static var burn: UIColor {
        return UIColor.text.withAlphaComponent(0.1)
    }
    
    static var separator: UIColor {
        return .gray
    }
}

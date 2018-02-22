import UIKit

extension UIColor {
    static var background: UIColor {
        switch Mode.current {
        case .light, .auto:
            return .white
        case .dark:
            return .black
        case .contrast:
            return .green
        }
    }
    
    static var text: UIColor {
        switch Mode.current {
        case .light, .auto:
            return .black
        case .dark:
            return .white
        case .contrast:
            return .purple
        }
    }
    
    static var separator: UIColor {
        switch Mode.current {
        case .contrast:
            return .text
        default:
            return .gray
        }
    }
    
    static var highlight: UIColor {
        switch Mode.current {
        case .contrast:
            return .orange
        default:
            return .gray
        }
    }
    
    static var burn: UIColor {
        switch Mode.current {
        case .light, .auto:
            return UIColor(white: 0.9, alpha: 1.0)
        case .dark:
            return UIColor(white: 0.15, alpha: 1.0)
        case .contrast:
            return .clear
        }
    }
}

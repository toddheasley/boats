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
    
    static func tint(_ alpha: CGFloat) -> UIColor {
        switch Mode.current {
        case .light, .auto:
            return UIColor.black.withAlphaComponent(alpha)
        case .dark:
            return UIColor.white.withAlphaComponent(alpha)
        case .contrast:
            return UIColor.orange.withAlphaComponent(alpha)
        }
    }
}

extension CGFloat {
    static var light: CGFloat {
        switch Mode.current {
        case .contrast:
            return 0.0
        default:
            return 0.05
        }
    }
    
    static var medium: CGFloat {
        switch Mode.current {
        case .contrast:
            return 1.0
        default:
            return 0.15
        }
    }
    
    static var heavy: CGFloat {
        return 0.4
    }
}

import UIKit

extension UIColor {
    static var foreground: UIColor = UIColor { traitCollection -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return background
        default:
            #if targetEnvironment(macCatalyst)
            return UIColor(white: 0.15, alpha: 1.0)
            #else
            return label
            #endif
        }
    }
    
    static var background: UIColor = UIColor { traitCollection -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            #if targetEnvironment(macCatalyst)
            return systemBackground
            #else
            return UIColor(white: 0.03, alpha: 1.0)
            #endif
        default:
            #if targetEnvironment(macCatalyst)
            return UIColor(white: 0.91, alpha: 1.0)
            #else
            return UIColor(white: 0.97, alpha: 1.0)
            #endif
        }
    }
    
    static func background(highlighted: Bool) -> UIColor {
        switch highlighted {
        case true:
            return highlightedBackground
        default:
            return background
        }
    }
    
    static func label(highlighted: Bool) -> UIColor {
        switch highlighted {
        case true:
            return highlightedLabel
        default:
            return label
        }
    }
    
    private static var highlightedBackground: UIColor = UIColor { traitCollection -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            #if targetEnvironment(macCatalyst)
            return UIColor(white: 0.16, alpha: 1.0)
            #else
            return UIColor(white: 0.1, alpha: 1.0)
            #endif
        default:
            return background
        }
    }
    
    private static var highlightedLabel: UIColor = UIColor { traitCollection -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return label
        default:
            return background
        }
    }
}

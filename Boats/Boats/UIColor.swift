import UIKit

extension UIColor {
    static var background: UIColor = UIColor { traitCollection -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            #if targetEnvironment(macCatalyst)
            return .secondarySystemBackground
            #else
            return .tertiarySystemBackground
            #endif
        default:
            #if targetEnvironment(macCatalyst)
            return UIColor(white: 0.91, alpha: 1.0)
            #else
            return UIColor(white: 0.97, alpha: 1.0)
            #endif
        }
    }
    
    static var foreground: UIColor = UIColor { traitCollection -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return UIColor(white: 0.0, alpha: 1.0)
        default:
            return  .label
        }
    }
    
    static func label(highlighted: Bool) -> UIColor {
        switch highlighted {
        case true:
            return .highlightedLabel
        default:
            return .label
        }
    }
    
    private static var highlightedLabel: UIColor = UIColor { traitCollection -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return .label
        default:
            return .background
        }
    }
}

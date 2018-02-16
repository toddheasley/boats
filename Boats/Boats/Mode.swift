import UIKit

enum Mode: String {
    case light
    case dark
    case contrast
    case auto
    
    static var current: Mode {
        switch UserDefaults.mode {
        case .auto:
            return UIScreen.main.mode
        default:
            return UserDefaults.mode
        }
    }
    
    var statusBarStyle: UIStatusBarStyle {
        switch self {
        case .dark:
            return .lightContent
        default:
            return .default
        }
    }
}

protocol ModeTransitioning {
    var mode: Mode {
        get
    }
    
    func transitionMode(duration: TimeInterval)
}

extension ModeTransitioning {
    var mode: Mode {
        return .current
    }
}

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
        switch Mode.current {
        case .contrast:
            return 1.0
        default:
            return 0.25
        }
    }
}

extension UserDefaults {
    static var mode: Mode {
        set {
            standard.set(newValue.rawValue, forKey: "mode")
        }
        get {
            return Mode(rawValue: standard.string(forKey: "mode") ?? "") ?? .auto
        }
    }
}

extension UIScreen {
    fileprivate var mode: Mode {
        return brightness > 0.35 ? .light : .dark
    }
}

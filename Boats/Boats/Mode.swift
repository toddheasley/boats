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
    static var fade: UIColor {
        switch Mode.current {
        case .contrast:
            return .clear
        default:
            return .tint
        }
    }
    
    static var tint: UIColor {
        switch Mode.current {
        case .light, .auto:
            return UIColor.black.withAlphaComponent(0.15)
        case .dark:
            return UIColor.white.withAlphaComponent(0.15)
        case .contrast:
            return UIColor.orange.withAlphaComponent(0.2)
        }
    }
    
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

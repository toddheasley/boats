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
    
    var indicatorStyle: UIScrollViewIndicatorStyle {
        switch self {
        case .dark:
            return .white
        default:
            return .black
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

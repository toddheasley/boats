import UIKit

enum Appearance: String, CaseIterable {
    case auto, light, dark
    
    static var shared: Appearance {
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "appearance")
            NotificationCenter.default.post(Notification(name: UIScreen.brightnessDidChangeNotification, object: nil, userInfo: nil))
        }
        get {
            return Appearance(rawValue: UserDefaults.standard.string(forKey: "appearance") ?? "") ?? .auto
        }
    }
    
    static var current: Appearance {
        switch shared {
        case .auto:
            return UIScreen.main.brightness > 0.6 ? .light : .dark
        default:
            return shared
        }
    }
}

extension Appearance: CustomStringConvertible {
    
    // MARK: CustomStringConvertible
    var description: String {
        return "\(rawValue)"
    }
}

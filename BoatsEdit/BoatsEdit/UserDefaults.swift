import Cocoa

extension UserDefaults {
    var web: NSControl.StateValue {
        set {
            set(newValue == .on, forKey: key)
        }
        get {
            return bool(forKey: key) ? .on : .off
        }
    }
    
    private var key: String {
        return "\(Bundle.main.bundleIdentifier!).web"
    }
}

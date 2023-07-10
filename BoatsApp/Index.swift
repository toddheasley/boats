import Foundation
import Boats

extension Index {
    var route: Route? {
        set {
            UserDefaults.standard.set(newValue?.uri, forKey: "route")
        }
        get {
            return route(uri: UserDefaults.standard.string(forKey: "route")) ?? routes.first
        }
    }
    
    private func route(uri: String?) -> Route? {
        return routes.first { $0.uri == uri }
    }
}

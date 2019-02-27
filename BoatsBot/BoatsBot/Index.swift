import Foundation
import BoatsKit

extension Index {
    public var current: Route? {
        set {
            UserDefaults.shared.set(data: newValue?.uri.data(using: .utf8), for: Key.current)
        }
        get {
            guard let data: Data = UserDefaults.shared.data(for: Key.current),
                let uri: String = String(data: data, encoding: .utf8), !uri.isEmpty else {
                    return nil
            }
            for route in routes {
                if route.uri == uri {
                    return route
                }
            }
            return nil
        }
    }
    
    static var context: [String: Any] {
        set {
            UserDefaults.shared.set(data: newValue[Key.current.stringValue] as? Data, for: Key.current)
        }
        get {
            var context: [String: Any] = [:]
            if let current: Data = UserDefaults.shared.data(for: Key.current) {
                context[Key.current.stringValue] = current
            }
            return context
        }
    }
    
    private enum Key: CodingKey, CaseIterable {
        case current
    }
}

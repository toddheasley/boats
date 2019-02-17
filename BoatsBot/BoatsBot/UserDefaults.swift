import Foundation
import BoatsKit

extension UserDefaults {
    public static var shared: UserDefaults = UserDefaults(suiteName: "group.toddheasley.boats") ?? .standard
}

extension UserDefaults {
    static let defaultsDidChangeNotification: Notification.Name = Notification.Name("defaultsDidChange")
    
    enum Availability {
        case ubiquitous, local
    }
    
    func set(data: Data?, for key: CodingKey, availability: Availability = .local) {
        switch availability {
        case .ubiquitous:
            #if !os(watchOS)
            NSUbiquitousKeyValueStore.default.set(data, forKey: key.stringValue)
            #endif
            fallthrough
        case.local:
            set(data, forKey: key.stringValue)
        }
        NotificationCenter.default.post(name: UserDefaults.defaultsDidChangeNotification, object: nil)
    }
    
    func data(for key: CodingKey) -> Data? {
        #if !os(watchOS)
        if let data: Data = NSUbiquitousKeyValueStore.default.data(forKey: key.stringValue) {
            return data
        }
        #endif
        return data(forKey: key.stringValue)
    }
}

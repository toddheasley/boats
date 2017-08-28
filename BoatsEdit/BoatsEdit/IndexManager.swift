//
//  BoatsEdit
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit
import BoatsWeb

protocol IndexManagerDelegate {
    
}

struct IndexManager {
    private(set) static var index: Index?
    
    static var url: URL? {
        set {
            UserDefaults.standard.set(newValue, forKey: "url")
        }
        get {
            return UserDefaults.standard.url(forKey: "url")
        }
    }
    
    static var web: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "web")
            
        }
        get {
            return UserDefaults.standard.bool(forKey: "web")
        }
    }
}

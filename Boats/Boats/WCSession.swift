import Foundation
import WatchConnectivity


extension WCSession {
    static var available: WCSession? {
        guard WCSession.isSupported(), WCSession.default.activationState == .activated else {
            return nil
        }
        return WCSession.default
    }
    
    static func activate(delegate: WCSessionDelegate? = nil) {
        guard WCSession.isSupported() else {
            return
        }
        WCSession.default.delegate = delegate
        WCSession.default.activate()
    }
}

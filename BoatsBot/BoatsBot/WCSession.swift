import Foundation
import WatchConnectivity
import BoatsKit

extension WCSession: WCSessionDelegate {
    public static func activate() {
        guard WCSession.isSupported() else {
            return
        }
        WCSession.default.delegate = WCSession.default
        WCSession.default.activate()
    }
    
    static var available: WCSession? {
        guard WCSession.isSupported(), WCSession.default.activationState == .activated else {
            return nil
        }
        return WCSession.default
    }
    
    @objc func handleDefaults() {
        try? updateApplicationContext(Index.context)
    }
    
    // MARK: WCSessionDelegate
    #if os(iOS)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        NotificationCenter.default.addObserver(self, selector: #selector(handleDefaults), name: UserDefaults.defaultsDidChangeNotification, object: nil)
        handleDefaults()
    }
    
    public func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    public func sessionDidDeactivate(_ session: WCSession) {
        NotificationCenter.default.removeObserver(self)
    }
    #elseif os(watchOS)
    public static let applicationContextDidChangeNotification: Notification.Name = Notification.Name("applicationContextDidChange")
    
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        update(context: session.receivedApplicationContext)
    }
    
    public func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        update(context: session.receivedApplicationContext)
    }
    
    private func update(context: [String: Any]) {
        Index.context = context
        NotificationCenter.default.post(name: WCSession.applicationContextDidChangeNotification, object: nil)
    }
    #endif
}

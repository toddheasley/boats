import UIKit
import WatchConnectivity
import BoatsBot
import BoatsKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {
    @objc func handleContext(notification: Notification?) {
        try? WCSession.available?.updateApplicationContext(Index.context)
    }
    
    // MARK: UIApplicationDelegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleContext(notification:)), name: Index.contextDidChangeNotification, object: nil)
        WCSession.activate(delegate: self)
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return connectingSceneSession.configuration
    }
    
    // MARK: WCSessionDelegate
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        try? session.updateApplicationContext(Index.context)
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
}

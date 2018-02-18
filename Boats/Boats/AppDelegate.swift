import UIKit
import BoatsKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var timer: Timer?
    
    @objc func applicationScreenBrightnessDidChange() {
        guard UserDefaults.mode == .auto else {
            return
        }
        NotificationCenter.default.post(name: Notification.Name.ModeChange, object: nil)
    }
    
    @objc func applicationTimeDidChange() {
        NotificationCenter.default.post(name: Notification.Name.TimeChange, object: nil)
    }
    
    // MARK: UIApplicationDelegate
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        applicationWillEnterForeground(application)
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        NotificationCenter.default.post(name: Notification.Name.ModeChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationScreenBrightnessDidChange), name: Notification.Name.UIScreenBrightnessDidChange, object: nil)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(applicationTimeDidChange), userInfo: nil, repeats: true)
        timer?.fire()
        
        window?.rootViewController?.viewWillAppear(false)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIScreenBrightnessDidChange, object: nil)
        timer?.invalidate()
    }
}

extension Notification.Name {
    static let ModeChange: Notification.Name = Notification.Name("ModeChange")
    static let TimeChange: Notification.Name = Notification.Name("TimeChange")
}

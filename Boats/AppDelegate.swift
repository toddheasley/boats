//
//  AppDelegate.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

typealias Data = BoatsData.Data
typealias Date = BoatsData.Date

let TimeChangeNotification: Notification.Name = Notification.Name("TimeChangeNotification")
let ModeChangeNotification: Notification.Name = Notification.Name("ModeChangeNotification")

enum Mode {
    case day, night
    
    init() {
        self = UIScreen.main.brightness > 0.35 ? .day : .night
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let timeInterval: TimeInterval = 10.0
    private var timer: Timer?
    var window: UIWindow?
    var mode: Mode = Mode()
    
    func applicationTimeDidChange() {
        NotificationCenter.default.post(name: TimeChangeNotification, object: nil)
    }
    
    func applicationScreenBrightnessDidChange() {
        guard mode != Mode() else {
            return
        }
        mode = Mode()
        NotificationCenter.default.post(name: ModeChangeNotification, object: nil)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        applicationWillEnterForeground(application)
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationScreenBrightnessDidChange), name: Notification.Name.UIScreenBrightnessDidChange, object: nil)
        applicationScreenBrightnessDidChange()
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(applicationTimeDidChange), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIScreenBrightnessDidChange, object: nil)
        timer?.invalidate()
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Data().reloadData { completed in
            completionHandler(completed ? .newData : .failed)
        }
    }
}

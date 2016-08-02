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

let TimeChangeNotification: NSNotification.Name = NSNotification.Name("TimeChangeNotification")

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let timeInterval: TimeInterval = 15.0
    private var timer: Timer?
    var window: UIWindow?
    
    func applicationTimeDidChange() {
        NotificationCenter.default.post(name: TimeChangeNotification, object: nil)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = NavigationController()
        window?.makeKeyAndVisible()
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(applicationTimeDidChange), userInfo: nil, repeats: true)
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(applicationTimeDidChange), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        timer?.invalidate()
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        Data().reloadData() { completed in
            completionHandler(completed ? .newData : .failed)
        }
    }
}

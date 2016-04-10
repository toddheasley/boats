//
//  AppDelegate.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import UIKit
import BoatsData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.rootViewController = MainTableViewController()
        window!.makeKeyAndVisible()
        return true
    }
    
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        Data.sharedData.reloadData { completed in
            completionHandler(completed ? .NewData : .Failed)
        }
    }
}

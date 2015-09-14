//
//  AppDelegate.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.rootViewController = MainTableViewController()
        window!.makeKeyAndVisible()
        return true
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        
    }
}

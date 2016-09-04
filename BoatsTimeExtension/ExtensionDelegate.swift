//
//  ExtensionDelegate.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import WatchKit
import BoatsData

typealias Data = BoatsData.Data
typealias Date = BoatsData.Date

let TimeChangeNotification: Notification.Name = Notification.Name("TimeChangeNotification")

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    private let timeInterval: TimeInterval = 15.0
    private var timer: Timer?
    
    func applicationTimeDidChange() {
        NotificationCenter.default.post(name: TimeChangeNotification, object: nil)
    }
    
    func applicationDidFinishLaunching() {
        
    }

    func applicationDidBecomeActive() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(applicationTimeDidChange), userInfo: nil, repeats: true)
        timer?.fire()
    }

    func applicationWillResignActive() {
        timer?.invalidate()
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        for backgroundTask in backgroundTasks {
            backgroundTask.setTaskCompleted()
        }
        
        /*
        for task in backgroundTasks {
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                backgroundTask.setTaskCompleted()
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Foundation.Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                connectivityTask.setTaskCompleted()
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                urlSessionTask.setTaskCompleted()
            default:
                task.setTaskCompleted()
            }
        }
        */
    }
}

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

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    func applicationDidFinishLaunching() {
        Data.group = "group.com.toddheasley.ios.boats"
    }

    func applicationDidBecomeActive() {
        
    }

    func applicationWillResignActive() {
        
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
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
    }
}

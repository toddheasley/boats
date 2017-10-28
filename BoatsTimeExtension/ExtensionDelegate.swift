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
    private let refreshInterval: TimeInterval = 4.0 * 60.0 * 60.0
    private let timeInterval: TimeInterval = 5.0
    private var timer: Timer?
    
    @objc func applicationTimeDidChange() {
        NotificationCenter.default.post(name: TimeChangeNotification, object: nil)
    }
    
    func scheduleBackgroundRefresh() {
        WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: Foundation.Date(timeIntervalSinceNow: refreshInterval), userInfo: nil) { error in
            guard let _ = error else {
                return
            }
            Data.refresh()
        }
    }

    func applicationDidBecomeActive() {
        scheduleBackgroundRefresh()
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(applicationTimeDidChange), userInfo: nil, repeats: true)
        timer?.fire()
    }

    func applicationWillResignActive() {
        timer?.invalidate()
        for complication in CLKComplicationServer.sharedInstance().activeComplications! {
            CLKComplicationServer.sharedInstance().reloadTimeline(for: complication)
        }
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        for task in backgroundTasks {
            switch task {
            case is WKApplicationRefreshBackgroundTask:
                Data.refresh { _ in
                    self.scheduleBackgroundRefresh()
                    for complication in CLKComplicationServer.sharedInstance().activeComplications! {
                        CLKComplicationServer.sharedInstance().reloadTimeline(for: complication)
                    }
                    task.setTaskCompleted()
                }
            default:
                task.setTaskCompleted()
            }
        }
    }
}

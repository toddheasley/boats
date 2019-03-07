import WatchKit
import WatchConnectivity
import BoatsKit
import BoatsBot

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    func refresh(completion: ((Error?) -> Void)? = nil) {
        URLSession.shared.index { index, error in
            if let index: Index = index {
                (WKExtension.shared().rootInterfaceController as? InterfaceController)?.index = index
                ComplicationController.index = index
            }
            WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: Date(timeIntervalSinceNow: 43200.0), userInfo: nil) { error in
                completion?(error)
            }
        }
    }
    
    // MARK: WKExtensionDelegate
    func applicationDidFinishLaunching() {
        WCSession.activate()
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: WCSession.applicationContextDidChangeNotification, object: nil)
    }
    
    func applicationDidBecomeActive() {
        refresh()
    }
    
    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        for task in backgroundTasks {
            switch task {
            case let refreshTask as WKApplicationRefreshBackgroundTask:
                refresh { _ in
                    refreshTask.setTaskCompletedWithSnapshot(true)
                }
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: .distantFuture, userInfo: nil)
            default:
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }
}

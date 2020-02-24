import WatchKit
import WatchConnectivity
import BoatsKit
import BoatsBot

class ExtensionDelegate: NSObject, WKExtensionDelegate, WCSessionDelegate {
    func refresh(cache timeInterval: TimeInterval = 30.0, completion: ((Error?) -> Void)? = nil) {
        URLSession.shared.index(cache: timeInterval) { index, error in
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
        WCSession.activate(delegate: self)
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
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        Index.context = session.receivedApplicationContext
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        Index.context = applicationContext
        refresh()
    }
}

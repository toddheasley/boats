import WatchKit
import BoatsKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    
    // MARK: WKExtensionDelegate
    func applicationDidFinishLaunching() {
        
    }
    
    func applicationDidBecomeActive() {
        
    }
    
    func applicationWillResignActive() {
        
    }
    
    func handle(_ tasks: Set<WKRefreshBackgroundTask>) {
        for task in tasks {
            switch task {
            case is WKApplicationRefreshBackgroundTask:
                task.setTaskCompletedWithSnapshot(false)
            case is WKSnapshotRefreshBackgroundTask:
                (task as? WKSnapshotRefreshBackgroundTask)?.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case is WKWatchConnectivityRefreshBackgroundTask:
                task.setTaskCompletedWithSnapshot(false)
            case is WKURLSessionRefreshBackgroundTask:
                task.setTaskCompletedWithSnapshot(false)
            default:
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }
}

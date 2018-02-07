import WatchKit
import Foundation
import UserNotifications

class NotificationController: WKUserNotificationInterfaceController {
    
    // MARK: WKUserNotificationInterfaceController
    override func didReceive(_ notification: UNNotification, withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Void) {
        completionHandler(.custom)
    }
    
    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    override init() {
        super.init()
    }
}

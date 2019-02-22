import UIKit
import NotificationCenter
import BoatsKit
import BoatsBot

class TodayViewController: UIViewController, NCWidgetProviding {
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: NCWidgetProviding
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(.noData)
    }
    
}

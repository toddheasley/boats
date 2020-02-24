import UIKit
import NotificationCenter
import BoatsKit
import BoatsBot

class TodayViewController: UIViewController, NCWidgetProviding {
    private(set) var index: Index {
        set {
            todayView.index = newValue
        }
        get {
            return todayView.index
        }
    }
    
    @objc func handleOpen() {
        extensionContext?.open(URL(string: "boats://")!, completionHandler: nil)
    }
    
    private let todayView: TodayView = TodayView()
    private let openControl: UIControl = UIControl()
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extensionContext?.widgetLargestAvailableDisplayMode = .compact
        
        todayView.index = Index()
        todayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        todayView.frame = view.bounds
        view.addSubview(todayView)
        
        openControl.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        openControl.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        openControl.frame = view.bounds
        view.addSubview(openControl)
    }
    
    // MARK: NCWidgetProviding
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        URLSession.shared.index { [weak self] index, error in
            self?.index = index ?? self!.index
            completionHandler(index != nil ? .newData : .noData)
        }
    }
}

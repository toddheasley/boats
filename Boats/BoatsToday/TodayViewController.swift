import UIKit
import NotificationCenter
import BoatsKit
import BoatsBot

class TodayViewController: UIViewController, NCWidgetProviding {
    @objc func handleOpen() {
        extensionContext?.open(URL(string: "boats://")!, completionHandler: nil)
    }
    
    private let emptyLabel: UILabel = UILabel()
    private let contentView: UIView = UIView()
    private let openControl: UIControl = UIControl()
    private let maxDepartures: Int = 3
    
    private var index: Index = Index() {
        didSet {
            for subview in contentView.subviews {
                subview.removeFromSuperview()
            }
            for complication in index.complications(limit: 3) {
                contentView.addSubview(TimetableView(complication: complication))
            }
            (contentView.subviews.first as? TimetableView)?.isHighlighted = true
            viewDidLayoutSubviews()
        }
    }
    
    private var route: Route {
        return index.current ?? index.routes.first!
    }
    
    // MARK: UIViewController
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        emptyLabel.isHidden = !contentView.subviews.isEmpty
        var y: CGFloat = 0.0
        for subview in contentView.subviews {
            subview.frame.size.width = contentView.bounds.size.width
            subview.frame.size.height = subview.intrinsicContentSize.height
            subview.frame.origin.y = y
            subview.alpha = y < view.bounds.size.height ? 1.0 : 0.0
            y += subview.frame.size.height
        }
        contentView.frame.size.height = y
        extensionContext?.widgetLargestAvailableDisplayMode = contentView.subviews.count > 1 ? .expanded : .compact
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = .compact
        
        emptyLabel.font = .systemFont(ofSize: 21.0, weight: .semibold)
        emptyLabel.text = "Schedule Unavailable"
        emptyLabel.textAlignment = .center
        emptyLabel.textColor = .color
        emptyLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        emptyLabel.frame = view.bounds
        view.addSubview(emptyLabel)
        
        contentView.autoresizingMask = [.flexibleWidth]
        contentView.frame.size.width = view.bounds.size.width
        view.addSubview(contentView)
        
        openControl.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        openControl.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        openControl.frame = view.bounds
        view.addSubview(openControl)
    }
    
    // MARK: NCWidgetProviding
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        emptyLabel.isHidden = true
        URLSession.shared.index { index, error in
            self.index = index ?? Index()
            completionHandler(index != nil ? .newData : .noData)
        }
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .expanded:
            preferredContentSize = CGSize(width: maxSize.width, height: contentView.bounds.size.height)
        default:
            preferredContentSize = maxSize
        }
    }
}

import UIKit
import SafariServices
import BoatsKit

class RouteViewController: ViewController, ScheduleViewDelegate, ToolbarDelegate, UIViewControllerTransitioningDelegate {
    
    @IBOutlet var scheduleView: ScheduleView?
    @IBOutlet var headerToolbar: RouteHeaderToolbar?
    @IBOutlet var footerToolbar: RouteFooterToolbar?
    
    var localization: Localization? {
        didSet {
            scheduleView?.localization = localization
            headerToolbar?.localization = localization
        }
    }
    
    var provider: Provider? {
        didSet {
            footerToolbar?.provider = provider
        }
    }
    
    var route: Route? {
        didSet {
            scheduleView?.schedule = route?.schedule()
            headerToolbar?.route = route
        }
    }
    
    // MARK: ViewController
    override func handleTimeChange() {
        super.handleTimeChange()
        
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        viewDidLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let scheduleView = scheduleView,
            let headerToolbar = headerToolbar,
            let footerToolbar = footerToolbar else {
                return
        }
        
        headerToolbar.frame.size.height = headerToolbar.intrinsicContentSize.height + view.safeAreaInsets.top
        
        footerToolbar.frame.size.height = footerToolbar.intrinsicContentSize.height + view.safeAreaInsets.bottom
        footerToolbar.frame.origin.y = view.bounds.size.height - footerToolbar.frame.size.height
        
        scheduleView.frame.origin.y = headerToolbar.frame.size.height
        scheduleView.frame.size.height = view.bounds.size.height - (scheduleView.frame.origin.y + footerToolbar.frame.size.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scheduleView?.localization = localization
        scheduleView?.schedule = route?.schedule()
        
        headerToolbar?.localization = localization
        headerToolbar?.route = route
        
        footerToolbar?.provider = provider
        
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    override func transitionMode(duration: TimeInterval) {
        super.transitionMode(duration: duration)
        
        scheduleView?.transitionMode(duration: duration)
        headerToolbar?.transitionMode(duration: duration)
        footerToolbar?.transitionMode(duration: duration)
    }
    
    // MARK: ScheduleViewDelegate
    func scheduleViewDidChangeDirection(_ view: ScheduleView) {
        headerToolbar?.direction = view.direction
    }
    
    // MARK: ToolbarDelegate
    func toolbar(_ toolbar: Toolbar, didOpen url: URL) {
        present(SFSafariViewController(url: url), animated: true)
    }
    
    func toolbarDidChange(_ toolbar: Toolbar) {
        if let toolbar = toolbar as? RouteHeaderToolbar {
            scheduleView?.direction = toolbar.direction
        }
    }
    
    func toolbarDidFinish(_ toolbar: Toolbar) {
        dismiss(animated: true)
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return RouteViewAnimator(.present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return RouteViewAnimator(.dismiss)
    }
}

class RouteViewAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    enum TransitionOperation {
        case present
        case dismiss
    }
    
    private(set) var operation: TransitionOperation = .present
    
    required init(_ operation: TransitionOperation) {
        super.init()
        self.operation = operation
    }
    
    // MARK: UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch operation {
        case .present:
            guard let viewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
                let routeViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? RouteViewController else {
                transitionContext.completeTransition(false)
                return
            }
            routeViewController.view.frame = CGRect(x: 0.0, y: transitionContext.containerView.bounds.size.height, width: transitionContext.containerView.bounds.size.width, height: 0.0)
            routeViewController.view.layoutIfNeeded()
            transitionContext.containerView.addSubview(viewController.view)
            transitionContext.containerView.addSubview(routeViewController.view)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: {
                routeViewController.view.frame = transitionContext.containerView.bounds
            }, completion: { _ in
                transitionContext.completeTransition(true)
            })
        case .dismiss:
            guard let viewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
                let routeViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? RouteViewController else {
                transitionContext.completeTransition(false)
                return
            }
            viewController.view.frame = transitionContext.containerView.bounds
            viewController.view.layoutIfNeeded()
            transitionContext.containerView.addSubview(viewController.view)
            transitionContext.containerView.addSubview(routeViewController.view)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                routeViewController.view.frame.origin.y = transitionContext.containerView.bounds.size.height
            }, completion: { finished in
                transitionContext.completeTransition(true)
            })
        }
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        
    }
}

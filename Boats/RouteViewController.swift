//
//  RouteViewController.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData
import SafariServices

class RouteViewController: ViewController, UINavigationControllerDelegate, UIScrollViewDelegate {
    private static let dateFormatter: DateFormatter = DateFormatter()
    private let scheduleViews: (destination: ScheduleView, origin: ScheduleView) = (ScheduleView(direction: .destination), ScheduleView(direction: .origin))
    
    var provider: Provider!
    var route: Route!
    
    @IBOutlet weak var routeLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var directionControl: UISegmentedControl!
    @IBOutlet weak var topSeparator: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomSeparator: UIView!
    @IBOutlet weak var providerButton: UIButton!
    @IBOutlet weak var popButton: UIButton!
    
    @IBAction func changeDirection(_ sender: AnyObject?) {
        scrollView.setContentOffset(CGPoint(x: (scrollView.bounds.size.width * CGFloat(directionControl.selectedSegmentIndex)), y: 0.0), animated: true)
    }
    
    @IBAction func openProviderURL(_ sender: AnyObject?) {
        present(SFSafariViewController(url: URL(string: provider.www)!), animated: true, completion: nil)
    }
    
    @IBAction func pop(_ sender: AnyObject?) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    override func dataDidRefresh() {
        super.dataDidRefresh()
        
        guard let provider = data.provider(code: self.provider.code), let route = provider.route(code: self.route.code) else {
            let _ = navigationController?.popViewController(animated: true)
            return
        }
        self.provider = provider
        self.route = route
        
        routeLabel.text = "\(route.name)"
        if let schedule = route.schedule() {
            RouteViewController.dateFormatter.dateFormat = "MMM d, yyyy"
            switch schedule.season {
            case .all:
                seasonLabel.text = "Year-Round"
            default:
                seasonLabel.text = "\(schedule.season.rawValue): \(RouteViewController.dateFormatter.string(from: schedule.dates.start.date)) - \(RouteViewController.dateFormatter.string(from: schedule.dates.end.date))"
            }
            scheduleViews.destination.schedule = schedule
            scheduleViews.origin.schedule = schedule
        } else {
            seasonLabel.text = "Schedule Unavailable"
            scheduleViews.destination.schedule = nil
            scheduleViews.origin.schedule = nil
        }
        directionControl.setTitle("From \(route.origin.name)".uppercased(), forSegmentAt: 0)
        directionControl.setTitle("To \(route.origin.name)".uppercased(), forSegmentAt: 1)
        providerButton.setTitle("Operated by \(provider.name)", for: .normal)
    }
    
    override func modeDidChange() {
        super.modeDidChange()
        
        routeLabel.textColor = .foreground(mode: mode)
        seasonLabel.textColor = routeLabel.textColor
        directionControl.tintColor = .tint(mode: mode)
        topSeparator.backgroundColor = routeLabel.textColor.withAlphaComponent(0.2)
        scrollView.backgroundColor = .background(mode: mode)
        scheduleViews.destination.color = routeLabel.textColor
        scheduleViews.origin.color = routeLabel.textColor
        bottomSeparator.backgroundColor = topSeparator.backgroundColor
        providerButton.setTitleColor(routeLabel.textColor, for: .normal)
        popButton.setImage(UIImage(named: "Pop")?.tint(color: directionControl.tintColor), for: .normal)
        popButton.setImage(UIImage(named: "Pop")?.tint(color: directionControl.tintColor.withAlphaComponent(0.4)), for: .highlighted)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.contentSize.width = scrollView.bounds.size.width * 2.0
        scrollView.contentSize.height = scrollView.bounds.size.height
        scrollViewDidEndDecelerating(scrollView)
        
        scheduleViews.destination.frame.size = scrollView.bounds.size
        scheduleViews.origin.frame.size = scrollView.bounds.size
        scheduleViews.origin.frame.origin.x = scrollView.bounds.size.width
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataDidRefresh()
        modeDidChange()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        directionControl.setTitleTextAttributes([
            NSFontAttributeName: UIFont.systemFont(ofSize: 9.0, weight: UIFontWeightHeavy)
        ], for: .normal)
        
        scrollView.addSubview(scheduleViews.destination)
        scrollView.addSubview(scheduleViews.origin)
    }
    
    // MARK: UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return RouteViewAnimator(operation: operation)
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        directionControl.selectedSegmentIndex = (scrollView.bounds.size.width > 0) ? min(Int(ceil(scrollView.contentOffset.x / scrollView.bounds.size.width)), 1) : 0
        scrollView.setContentOffset(CGPoint(x: (scrollView.bounds.size.width * CGFloat(directionControl.selectedSegmentIndex)), y: 0.0), animated: true)
    }
}

protocol RouteViewDelegate {
    func routeViewRect(controller: RouteViewController) -> CGRect?
}

class RouteViewAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration: TimeInterval = 1.0
    private(set) var operation: UINavigationControllerOperation = .none
    
    required init?(operation: UINavigationControllerOperation? = nil) {
        super.init()
        guard let operation = operation , operation == .push || operation == .pop else {
            return nil
        }
        self.operation = operation
    }
    
    // MARK: UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        switch operation {
        case .push, .pop:
            return duration
        case .none:
            return 0.0
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? ViewController, let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? ViewController else {
            transitionContext.completeTransition(false)
            return
        }
        let view = UIView(frame: transitionContext.containerView.bounds)
        view.frame.origin.y = view.frame.size.height
        view.backgroundColor = .highlight()
        
        switch self.operation {
        case .push:
            if let controller = toViewController as? RouteViewController, let delegate = fromViewController as? RouteViewDelegate, let rect = delegate.routeViewRect(controller: controller) {
                view.frame = rect
            }
            transitionContext.containerView.backgroundColor = fromViewController.view.backgroundColor
            transitionContext.containerView.addSubview(fromViewController.view)
            transitionContext.containerView.addSubview(view)
            toViewController.view.layer.transform = CATransform3DMakeScale(1.0, 0.6, 1.0)
            toViewController.view.alpha = 0.0
            transitionContext.containerView.addSubview(toViewController.view)
            UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: {
                fromViewController.view.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0)
                view.backgroundColor = toViewController.view.backgroundColor
                view.frame = transitionContext.containerView.bounds
                toViewController.view.layer.transform = CATransform3DIdentity
                toViewController.view.alpha = 1.0
            }, completion: { _ in
                view.removeFromSuperview()
                fromViewController.view.layer.transform = CATransform3DIdentity
                transitionContext.completeTransition(true)
            })
        case .pop:
            transitionContext.containerView.backgroundColor = toViewController.view.backgroundColor
            transitionContext.containerView.addSubview(toViewController.view)
            toViewController.view.frame = transitionContext.containerView.bounds
            toViewController.view.layoutIfNeeded()
            toViewController.view.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0)
            var frame = view.frame
            if let controller = fromViewController as? RouteViewController, let delegate = toViewController as? RouteViewDelegate, let rect = delegate.routeViewRect(controller: controller) {
                frame = rect
            }
            view.frame = transitionContext.containerView.bounds
            transitionContext.containerView.addSubview(view)
            transitionContext.containerView.addSubview(fromViewController.view)
            UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                toViewController.view.layer.transform = CATransform3DIdentity
                fromViewController.view.layer.transform = CATransform3DMakeScale(1.0, 0.6, 1.0)
                fromViewController.view.alpha = 0.0
                view.frame = frame
            }, completion: { finished in
                
                view.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        case .none:
            transitionContext.completeTransition(false)
        }
    }
}

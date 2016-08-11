//
//  RouteViewController.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData
import SafariServices

class RouteViewController: ViewController, UIScrollViewDelegate {
    private static let dateFormatter: DateFormatter = DateFormatter(dateFormat: "MMM d, yyyy")
    private let highlightView: UIView = UIView()
    private let scrollView: UIScrollView = UIScrollView()
    private let scrollViewBorder: CALayer = CALayer()
    private let scheduleViews: (destination: ScheduleView, origin: ScheduleView) = (ScheduleView(direction: .destination), ScheduleView(direction: .origin))
    private let routeLabel: UILabel = UILabel()
    private let seasonLabel: UILabel = UILabel()
    private let directionControl: DirectionControl = DirectionControl()
    private let providerControl: ProviderControl = ProviderControl()
    private let popControl: PopControl = PopControl()
    private(set) var provider: Provider!
    private(set) var route: Route!
    
    var controlsHidden: Bool = false {
        didSet {
            viewDidLayoutSubviews()
        }
    }
    
    func changeDirection(sender: AnyObject?) {
        scrollView.setContentOffset(CGPoint(x: (scrollView.bounds.size.width * CGFloat(directionControl.selectedSegmentIndex)), y: 0.0), animated: true)
    }
    
    func openProviderURL(sender: AnyObject?) {
        present(SFSafariViewController(url: URL(string: provider.www)!), animated: true, completion: nil)
    }
    
    func pop(sender: AnyObject?) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    override func dataDidRefresh(completed: Bool) {
        super.dataDidRefresh(completed: completed)
        if completed {
            guard let provider = data.provider(code: self.provider.code), let route = provider.route(code: self.route.code) else {
                let _ = navigationController?.popViewController(animated: true)
                return
            }
            self.provider = provider
            self.route = route
            
            routeLabel.text = self.route.name
            directionControl.origin = route.origin
            if let schedule = route.schedule() {
                seasonLabel.text = schedule.season == .all ? "Year-Round" : "\(schedule.season.rawValue): \(RouteViewController.dateFormatter.string(start: schedule.dates.start, end: schedule.dates.end))"
                scheduleViews.destination.schedule = schedule
                scheduleViews.origin.schedule = schedule
            } else {
                seasonLabel.text = "Schedule Unavailable"
                scheduleViews.destination.schedule = nil
                scheduleViews.origin.schedule = nil
            }
            providerControl.text = "Operated by \(self.provider.name)"
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        dataDidRefresh(completed: true)
        let scheduleHidden: Bool = route.schedule() == nil
        
        routeLabel.frame.size.width = view.layoutRect.size.width
        routeLabel.frame.origin.x = view.layoutRect.origin.x
        routeLabel.frame.origin.y = view.layoutRect.origin.y + 2.0 + (view.frame.origin.y < view.statusBarHeight ? view.statusBarHeight : 0.0)
        routeLabel.textColor = .foreground
        
        seasonLabel.frame.size.width = routeLabel.frame.size.width
        seasonLabel.frame.origin.x = routeLabel.frame.origin.x
        seasonLabel.frame.origin.y = routeLabel.frame.origin.y + routeLabel.frame.size.height + 1.0
        seasonLabel.textColor = routeLabel.textColor
        seasonLabel.isHidden = controlsHidden
        
        directionControl.frame.size.width = routeLabel.frame.size.width
        directionControl.frame.origin.x = routeLabel.frame.origin.x
        directionControl.frame.origin.y = seasonLabel.frame.origin.y + seasonLabel.frame.size.height + view.layoutEdgeInsets.top
        directionControl.isHidden = controlsHidden || scheduleHidden
        
        scrollView.frame.origin.y = directionControl.frame.origin.y + directionControl.frame.size.height + view.layoutInterItemSpacing.height
        scrollView.frame.size.height = view.bounds.size.height - (scrollView.frame.origin.y + providerControl.frame.size.height + view.layoutInterItemSpacing.height + view.layoutEdgeInsets.bottom)
        scrollView.contentSize.width = scrollView.bounds.size.width * 2.0
        scrollView.contentSize.height = scrollView.bounds.size.height
        scrollView.backgroundColor = .background
        scrollView.isHidden = controlsHidden || scheduleHidden
        scrollView.delegate = self
        scrollViewDidEndDecelerating(scrollView)
        
        scrollViewBorder.frame = CGRect(x: -0.5, y: 0.0, width: scrollView.bounds.size.width + 1.0, height: scrollView.bounds.size.height)
        scrollViewBorder.borderColor = UIColor.foreground.disabled.cgColor
        
        scheduleViews.destination.frame.size = scrollView.bounds.size
        scheduleViews.origin.frame.size = scrollView.bounds.size
        scheduleViews.origin.frame.origin.x = scrollView.bounds.size.width
        
        popControl.frame.size.width = popControl.intrinsicContentSize.width + view.layoutEdgeInsets.left + view.layoutEdgeInsets.right
        popControl.frame.size.height = popControl.intrinsicContentSize.height + (view.layoutInterItemSpacing.height * 2.0)
        popControl.frame.origin.x = view.bounds.size.width - popControl.frame.size.width
        popControl.frame.origin.y = scrollView.frame.origin.y + scrollView.frame.size.height
        popControl.isHidden = controlsHidden
        
        providerControl.frame.size.width = view.layoutRect.size.width - popControl.frame.size.width
            providerControl.frame.origin.x = view.layoutRect.origin.x
        providerControl.frame.origin.y = view.bounds.size.height - (providerControl.frame.size.height + view.layoutEdgeInsets.bottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highlightView.frame = view.bounds
        highlightView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        highlightView.backgroundColor = .highlight
        view.addSubview(highlightView)
        
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.frame.size.width = view.bounds.size.width
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        scrollViewBorder.borderWidth = 0.5
        scrollView.layer.addSublayer(scrollViewBorder)
        
        scrollView.addSubview(scheduleViews.destination)
        scrollView.addSubview(scheduleViews.origin)
        
        routeLabel.font = .large
        routeLabel.text = " "
        routeLabel.sizeToFit()
        view.addSubview(routeLabel)
        
        seasonLabel.font = .regular
        seasonLabel.text = " "
        seasonLabel.sizeToFit()
        view.addSubview(seasonLabel)
        
        directionControl.frame.size.height = directionControl.intrinsicContentSize.height
        directionControl.addTarget(self, action: #selector(changeDirection(sender:)), for: .valueChanged)
        view.addSubview(directionControl)
        
        providerControl.frame.size.height = providerControl.intrinsicContentSize.height
        providerControl.addTarget(self, action: #selector(openProviderURL(sender:)), for: .touchUpInside)
        view.addSubview(providerControl)
        
        popControl.addTarget(self, action: #selector(pop(sender:)), for: .touchUpInside)
        view.addSubview(popControl)
    }
    
    required init?(provider: Provider?, route: Route?) {
        super.init(nibName: nil, bundle: nil)
        guard let provider = provider, let route = route else {
            return nil
        }
        self.provider = provider
        self.route = route
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
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
    private let animationDuration: TimeInterval = 0.2
    private let scale: CGFloat = 0.8
    private let borderWidth: CGFloat = 0.5
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
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextFromViewControllerKey) as? ViewController, let toViewController = transitionContext.viewController(forKey: UITransitionContextToViewControllerKey) as? ViewController else {
            transitionContext.completeTransition(false)
            return
        }
        let view = transitionContext.containerView
        let pushRect = CGRect(x: 0.0, y: view.statusBarHeight, width: view.bounds.size.width, height: view.bounds.size.height - view.statusBarHeight)
        var popRect = CGRect(x: 0.0, y: view.bounds.size.height, width: view.bounds.size.width, height: 0.0)
        var animations:(Void) -> Void = { }
        switch self.operation {
        case .push:
            if let controller = toViewController as? RouteViewController, let delegate = fromViewController as? RouteViewDelegate, let rect = delegate.routeViewRect(controller: controller) {
                controller.controlsHidden = true
                popRect = rect
            }
            view.backgroundColor = fromViewController.view.backgroundColor
            view.addSubview(fromViewController.view)
            view.addSubview(toViewController.view)
            toViewController.view.layer.borderWidth = self.borderWidth
            toViewController.view.layer.borderColor = UIColor.foreground.disabled.cgColor
            toViewController.view.frame = popRect
            animations = {
                toViewController.view.frame = pushRect
                fromViewController.view.layer.transform = CATransform3DMakeScale(self.scale, self.scale, 1.0)
                fromViewController.view.layer.opacity = 0.25
            }
        case .pop:
            view.backgroundColor = toViewController.view.backgroundColor
            view.addSubview(toViewController.view)
            view.addSubview(fromViewController.view)
            toViewController.view.frame = view.bounds
            toViewController.view.layer.transform = CATransform3DMakeScale(self.scale, self.scale, 1.0)
            toViewController.view.layer.opacity = 0.25
            fromViewController.view.layer.borderWidth = self.borderWidth
            fromViewController.view.layer.borderColor = UIColor.foreground.disabled.cgColor
            if let controller = fromViewController as? RouteViewController, let delegate = toViewController as? RouteViewDelegate, let rect = delegate.routeViewRect(controller: controller) {
                controller.controlsHidden = true
                popRect = rect
            }
            fromViewController.view.frame = pushRect
            animations = {
                fromViewController.view.frame = popRect
                toViewController.view.layer.transform = CATransform3DIdentity
                toViewController.view.layer.opacity = 1.0
            }
        case .none:
            transitionContext.completeTransition(false)
            return
        }
        UIView.animate(withDuration: animationDuration, animations: animations, completion: { finished in
            fromViewController.view.layer.transform = CATransform3DIdentity
            fromViewController.view.layer.borderWidth = 0.0
            fromViewController.view.layer.opacity = 1.0
            toViewController.view.layer.transform = CATransform3DIdentity
            toViewController.view.frame = view.bounds
            toViewController.view.layer.borderWidth = 0.0
            toViewController.view.layer.opacity = 1.0
            if let controller = toViewController as? RouteViewController {
                controller.controlsHidden = false
            }
            transitionContext.completeTransition(finished)
        })
    }
}

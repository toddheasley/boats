//
//  RouteViewController.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class RouteViewController: ViewController, ProviderViewDelegate, RouteViewDelegate {
    private let highlightView: UIView = UIView()
    private let providerView: ProviderView = ProviderView()
    private let routeLabel: UILabel = UILabel()
    private let scheduleLabel: ScheduleLabel = ScheduleLabel()
    private let contentView: UIView = UIView()
    private let contentLabel: UILabel = UILabel()
    private let todayView: TodayView = TodayView()
    private let scheduleView: ScheduleView = ScheduleView()
    
    private var rect: CGRect?
    private(set) var provider: Provider!
    private(set) var route: Route!
    
    override func dataDidRefresh(completed: Bool) {
        super.dataDidRefresh(completed: completed)
        if (completed) {
            guard let provider = data.provider(code: self.provider.code), let route = provider.route(code: self.route.code) else {
                let _ = navigationController?.popViewController(animated: true)
                return
            }
            self.provider = provider
            self.route = route
            
            providerView.provider = self.provider
            routeLabel.text = self.route.name
            if let schedule = route.schedule() {
                scheduleLabel.schedule = schedule
                contentLabel.isHidden = true
                todayView.isHidden = false
                scheduleView.isHidden = false
            } else {
                scheduleLabel.schedule = nil
                contentLabel.isHidden = true
                todayView.isHidden = true
                scheduleView.isHidden = true
            }
            todayView.route = self.route
            scheduleView.route = self.route
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dataDidRefresh(completed: true)
        
        providerView.frame.size.width = view.suggestedFrame.size.width
        providerView.frame.size.height = providerView.intrinsicContentSize().height
        providerView.frame.origin.x = view.suggestedFrame.origin.x
        providerView.frame.origin.y = view.suggestedContentInset.bottom + view.statusBarHeight
        
        routeLabel.frame.origin.x = providerView.frame.origin.x
        routeLabel.frame.origin.y = providerView.frame.origin.y + providerView.frame.size.height
        routeLabel.sizeToFit()
        
        scheduleLabel.frame.origin.x = routeLabel.frame.origin.x + routeLabel.frame.size.width + 5.0
        scheduleLabel.frame.origin.y = routeLabel.frame.origin.y
        scheduleLabel.frame.size.width = providerView.frame.size.width - (scheduleLabel.frame.origin.x - routeLabel.frame.origin.x)
        
        contentView.frame.origin.y = routeLabel.frame.origin.y + routeLabel.frame.size.height
        contentView.frame.size.height = view.bounds.size.height - contentView.frame.origin.y
        contentLabel.frame.size.width = contentView.bounds.size.width
        contentLabel.frame.size.height = contentView.frame.size.height - contentView.frame.origin.y
        
        routeLabel.textColor = .foreground
        contentLabel.textColor = UIColor.foreground.disabled
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.clipsToBounds = true
        
        highlightView.frame = view.bounds
        highlightView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        highlightView.backgroundColor = .highlight
        view.addSubview(highlightView)
        
        routeLabel.font = .large
        routeLabel.text = " "
        routeLabel.sizeToFit()
        view.addSubview(routeLabel)
        
        scheduleLabel.font = routeLabel.font
        scheduleLabel.text = " "
        scheduleLabel.sizeToFit()
        view.addSubview(scheduleLabel)
        
        contentView.frame = view.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(contentView)
        
        contentLabel.font = .xlarge
        contentLabel.textAlignment = .center
        contentLabel.text = "No Active Schedule"
        contentView.addSubview(contentLabel)
        
        todayView.delegate = self
        todayView.expand(animated: false)
        todayView.isHidden = true
        contentView.addSubview(todayView)
        
        scheduleView.delegate = self
        scheduleView.collapse(animated: false)
        scheduleView.isHidden = true
        contentView.addSubview(scheduleView)
        
        providerView.delegate = self
        view.addSubview(providerView)
        
        dataDidRefresh(completed: true)
    }
    
    convenience init?(provider: Provider?, route: Route?, rect: CGRect? = nil) {
        self.init()
        guard let provider = provider, let route = route else {
            return nil
        }
        self.rect = rect
        self.provider = provider
        self.route = route
    }
    
    override func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return RouteViewControllerAnimator(operation: operation, rect: rect)
    }
    
    // MARK: ProviderViewDelegate
    func providerViewDidPop(view: ProviderView) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: RouteViewDelegate
    func routeViewCanExpand(view: RouteView, animated: Bool) -> Bool {
        switch view {
        case todayView:
            scheduleView.collapse(animated: animated)
        case scheduleView:
            todayView.collapse(animated: animated)
        default:
            break
        }
        return true
    }
    
    func routeViewFrame(view: RouteView, expanded: Bool) -> CGRect {
        view.autoresizingMask = expanded ? [.flexibleWidth, .flexibleHeight] : [.flexibleWidth, .flexibleTopMargin]
        
        var frame = contentView.bounds
        frame.size.height = expanded ? contentView.bounds.size.height - 44.0 : 44.0
        frame.origin.y = expanded ? 0.0 : contentView.bounds.size.height - 44.0
        return frame
    }
    
    func routeViewDidExpand(view: RouteView) {
        contentView.sendSubview(toBack: view)
    }
}

class RouteViewControllerAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 0.25
    private let scale: CGFloat = 0.8
    private let borderWidth: CGFloat = 0.5
    private var rect: CGRect?
    private(set) var operation: UINavigationControllerOperation = .none
    
    required init?(operation: UINavigationControllerOperation? = nil, rect: CGRect? = nil) {
        super.init()
        guard let operation = operation , operation == .push || operation == .pop else {
            return nil
        }
        self.operation = operation
        self.rect = rect
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
        let view = transitionContext.containerView()
        var frame = CGRect(x: 0.0, y: view.bounds.size.height, width: view.bounds.size.width, height: 0.0)
        if let rect = rect {
            frame = rect
        }
        var animations:(Void) -> Void = { }
        switch self.operation {
        case .push:
            view.backgroundColor = fromViewController.view.backgroundColor
            view.addSubview(fromViewController.view)
            view.addSubview(toViewController.view)
            toViewController.view.layer.borderWidth = self.borderWidth
            toViewController.view.layer.borderColor = UIColor.foreground.disabled.cgColor
            toViewController.view.frame = frame
            animations = {
                toViewController.view.frame = view.bounds
                fromViewController.view.layer.transform = CATransform3DMakeScale(self.scale, self.scale, 1.0)
                fromViewController.view.layer.opacity = 0.25
            }
        case .pop:
            view.backgroundColor = toViewController.view.backgroundColor
            view.addSubview(toViewController.view)
            view.addSubview(fromViewController.view)
            toViewController.view.layer.transform = CATransform3DMakeScale(self.scale, self.scale, 1.0)
            toViewController.view.layer.opacity = 0.25
            fromViewController.view.layer.borderWidth = self.borderWidth
            fromViewController.view.layer.borderColor = UIColor.foreground.disabled.cgColor
            fromViewController.view.frame = view.bounds
            animations = {
                fromViewController.view.frame = frame
                toViewController.view.layer.transform = CATransform3DIdentity
                toViewController.view.layer.opacity = 1.0
            }
        case .none:
            transitionContext.completeTransition(false)
            return
        }
        UIView.animate(withDuration: animationDuration, animations: animations, completion: { finished in
            fromViewController.view.layer.borderWidth = 0.0
            fromViewController.view.layer.opacity = 1.0
            toViewController.view.layer.borderWidth = 0.0
            toViewController.view.layer.opacity = 1.0
            transitionContext.completeTransition(finished)
        })
    }
}

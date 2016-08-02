//
//  RouteViewController.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class RouteViewController: ViewController, UIScrollViewDelegate {
    private let highlightView: UIView = UIView()
    private let scrollView: UIScrollView = UIScrollView()
    var scrollViewBorder: CALayer = CALayer()
    private let routeLabel: UILabel = UILabel()
    private let providerLabel: UILabel = UILabel()
    private var rect: CGRect?
    private(set) var provider: Provider!
    private(set) var route: Route!
    
    func pop(sender: AnyObject?) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    override func dataDidRefresh(completed: Bool) {
        super.dataDidRefresh(completed: completed)
        if (completed) {
            guard let provider = data.provider(code: self.provider.code), let route = provider.route(code: self.route.code) else {
                let _ = navigationController?.popViewController(animated: true)
                return
            }
            self.provider = provider
            self.route = route
            
            routeLabel.text = self.route.name
            providerLabel.text = "Operated by \(self.provider.name)"
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        dataDidRefresh(completed: true)
        
        routeLabel.frame.size.width = view.layoutRect.size.width
        routeLabel.frame.origin.x = view.layoutRect.origin.x
        routeLabel.frame.origin.y = view.layoutRect.origin.y + 2.0 + (view.frame.origin.y < view.statusBarHeight ? view.statusBarHeight : 0.0)
        routeLabel.textColor = .foreground(status: .future)
        
        scrollView.frame.origin.y = routeLabel.frame.origin.y + routeLabel.frame.size.height
        scrollView.frame.size.height = view.bounds.size.height - (scrollView.frame.origin.y + 0.0)
        scrollView.contentSize.width = scrollView.bounds.size.width * 2.0
        scrollView.contentSize.height = scrollView.bounds.size.height
        scrollView.backgroundColor = .background
        scrollViewDidEndDecelerating(scrollView)
        
        scrollViewBorder.frame = CGRect(x: -0.5, y: 0.0, width: scrollView.bounds.size.width + 1.0, height: scrollView.bounds.size.height)
        scrollViewBorder.isHidden = scrollViewBorder.frame.size.height < (rect?.size.height ?? 0.0)
        scrollViewBorder.borderColor = UIColor.foreground.disabled.cgColor
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
        
        routeLabel.font = .large
        routeLabel.text = " "
        routeLabel.sizeToFit()
        view.addSubview(routeLabel)
        
        providerLabel.font = .regular
        providerLabel.text = " "
        providerLabel.sizeToFit()
        //view.addSubview(providerLabel)
        
        let popControl = UIControl()
        popControl.addTarget(self, action: #selector(pop(sender:)), for: .touchUpInside)
        popControl.frame = view.bounds
        popControl.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(popControl)
    }
    
    required init?(provider: Provider?, route: Route?, rect: CGRect? = nil) {
        super.init(nibName: nil, bundle: nil)
        guard let provider = provider, let route = route else {
            return nil
        }
        self.rect = rect
        self.provider = provider
        self.route = route
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return RouteViewControllerAnimator(operation: operation, rect: rect)
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
}

class RouteViewControllerAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 0.2
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
        let view = transitionContext.containerView
        let fromRect = rect ?? CGRect(x: 0.0, y: view.bounds.size.height, width: view.bounds.size.width, height: 0.0)
        let toRect = CGRect(x: 0.0, y: view.statusBarHeight, width: view.bounds.size.width, height: view.bounds.size.height - view.statusBarHeight)
        var animations:(Void) -> Void = { }
        switch self.operation {
        case .push:
            view.backgroundColor = fromViewController.view.backgroundColor
            view.addSubview(fromViewController.view)
            view.addSubview(toViewController.view)
            toViewController.view.layer.borderWidth = self.borderWidth
            toViewController.view.layer.borderColor = UIColor.foreground.disabled.cgColor
            toViewController.view.frame = fromRect
            animations = {
                toViewController.view.frame = toRect
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
            fromViewController.view.frame = toRect
            animations = {
                fromViewController.view.frame = fromRect
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
            toViewController.view.frame = view.bounds
            toViewController.view.layer.borderWidth = 0.0
            toViewController.view.layer.opacity = 1.0
            transitionContext.completeTransition(finished)
        })
    }
}

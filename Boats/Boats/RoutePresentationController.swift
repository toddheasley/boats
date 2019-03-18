import UIKit

protocol RoutePresentationDelegate: UIViewControllerTransitioningDelegate {
    func animationOrigin() -> CGRect?
}

class RoutePresentationController: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration: TimeInterval = 0.75
    
    private func present(_ routeViewController: RouteViewController, from viewController: UIViewController, with context: UIViewControllerContextTransitioning) {
        context.containerView.backgroundColor = viewController.view.backgroundColor
        context.containerView.addSubview(viewController.view)
        
        let view: UIView = UIView(frame: transitionOrigin(context: context, delegate: routeViewController.transitioningDelegate))
        view.backgroundColor = .color
        context.containerView.addSubview(view)
        
        routeViewController.view.layer.transform = CATransform3DMakeScale(1.0, 0.6, 1.0)
        routeViewController.view.alpha = 0.0
        context.containerView.addSubview(routeViewController.view)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: {
            viewController.view.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0)
            view.backgroundColor = routeViewController.view.backgroundColor
            view.frame = context.containerView.bounds
            routeViewController.view.layer.transform = CATransform3DIdentity
            routeViewController.view.alpha = 1.0
        }, completion: { _ in
            view.removeFromSuperview()
            viewController.view.layer.transform = CATransform3DIdentity
            context.completeTransition(true)
        })
    }
    
    private func dismiss(_ routeViewController: RouteViewController, from viewController: UIViewController, with context: UIViewControllerContextTransitioning) {
        context.containerView.backgroundColor = viewController.view.backgroundColor
        viewController.view.frame = context.containerView.bounds
        context.containerView.addSubview(viewController.view)
        viewController.view.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0)
        
        let view: UIView = UIView(frame: context.containerView.bounds)
        view.backgroundColor = .color
        context.containerView.addSubview(view)
        
        context.containerView.addSubview(routeViewController.view)
        
        let origin: CGRect = transitionOrigin(context: context, delegate:  routeViewController.transitioningDelegate)
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            viewController.view.layer.transform = CATransform3DIdentity
            routeViewController.view.layer.transform = CATransform3DMakeScale(1.0, 0.6, 1.0)
            routeViewController.view.alpha = 0.0
            view.frame = origin
            view.alpha = 0.0
        }, completion: { _ in
            view.removeFromSuperview()
            routeViewController.view.layer.transform = CATransform3DIdentity
            routeViewController.view.removeFromSuperview()
            context.completeTransition(true)
        })
    }
    
    private func transitionOrigin(context: UIViewControllerContextTransitioning, delegate: UIViewControllerTransitioningDelegate? = nil) -> CGRect {
        return (delegate as? RoutePresentationDelegate)?.animationOrigin() ?? CGRect(origin: CGPoint(x: 0.0, y: context.containerView.bounds.size.height), size: context.containerView.bounds.size)
    }
    
    // MARK: UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let routeViewController: RouteViewController = transitionContext.viewController(forKey: .to) as? RouteViewController,
            let viewController: UIViewController = transitionContext.viewController(forKey: .from) {
            present(routeViewController, from: viewController, with: transitionContext)
        } else if let routeViewController: RouteViewController = transitionContext.viewController(forKey: .from) as? RouteViewController,
            let viewController: UIViewController = transitionContext.viewController(forKey: .to) {
            dismiss(routeViewController, from: viewController, with: transitionContext)
        } else {
            transitionContext.completeTransition(false)
        }
    }
}

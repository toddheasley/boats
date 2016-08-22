//
//  RouteViewController.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData
import SafariServices

/*
class RouteViewController: ViewController, UIScrollViewDelegate {
    private let highlightView: UIView = UIView()
    private let scrollView: UIScrollView = UIScrollView()
    private let routeLabel: RouteLabel = RouteLabel()
    private let seasonLabel: SeasonLabel = SeasonLabel()
    private let directionControl: DirectionControl = DirectionControl()
    private let scheduleViews: (destination: ScheduleView, origin: ScheduleView) = (ScheduleView(direction: .destination), ScheduleView(direction: .origin))
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
        guard let sender = sender as? ProviderControl, let provider = sender.provider else {
            return
        }
        present(SFSafariViewController(url: URL(string: provider.www)!), animated: true, completion: nil)
    }
    
    func pop(sender: AnyObject?) {
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
        
        routeLabel.route = self.route
        seasonLabel.schedule = self.route.schedule()
        directionControl.origin = self.route.origin
        scheduleViews.destination.schedule = seasonLabel.schedule
        scheduleViews.origin.schedule = seasonLabel.schedule
        providerControl.provider = self.provider
    }
    
    override func modeDidChange() {
        super.modeDidChange()
        
        highlightView.backgroundColor = UIColor.foreground(mode: mode).highlight
        scrollView.backgroundColor = .background(mode: mode)
        routeLabel.mode = mode
        seasonLabel.mode = mode
        directionControl.mode = mode
        scheduleViews.destination.mode = mode
        scheduleViews.origin.mode = mode
        providerControl.mode = mode
        popControl.mode = mode        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        dataDidRefresh()
        let scheduleHidden: Bool = route.schedule() == nil
        
        routeLabel.frame.size.width = view.layoutRect.size.width
        routeLabel.frame.origin.x = view.layoutRect.origin.x
        routeLabel.frame.origin.y = view.layoutRect.origin.y + (view.frame.origin.y < UIApplication.shared.statusBarFrame.size.height ? UIApplication.shared.statusBarFrame.size.height : 0.0)
        
        seasonLabel.frame.size.width = routeLabel.frame.size.width
        seasonLabel.frame.origin.x = routeLabel.frame.origin.x
        seasonLabel.frame.origin.y = routeLabel.frame.origin.y + routeLabel.frame.size.height
        seasonLabel.isHidden = controlsHidden
        
        directionControl.frame.size.width = routeLabel.frame.size.width
        directionControl.frame.origin.x = routeLabel.frame.origin.x
        directionControl.frame.origin.y = seasonLabel.frame.origin.y + seasonLabel.frame.size.height + view.layoutEdgeInsets.top
        directionControl.isHidden = controlsHidden || scheduleHidden
        
        scrollView.frame.origin.y = directionControl.frame.origin.y + directionControl.frame.size.height + view.layoutInterItemSpacing.height
        scrollView.frame.size.height = view.bounds.size.height - (scrollView.frame.origin.y + providerControl.frame.size.height + view.layoutInterItemSpacing.height + view.layoutEdgeInsets.bottom)
        scrollView.contentSize.width = scrollView.bounds.size.width * 2.0
        scrollView.contentSize.height = scrollView.bounds.size.height
        scrollView.isHidden = controlsHidden || scheduleHidden
        scrollView.delegate = self
        scrollViewDidEndDecelerating(scrollView)
        
        scheduleViews.destination.frame.size = scrollView.bounds.size
        scheduleViews.destination.reloadData()
        scheduleViews.origin.frame.size = scrollView.bounds.size
        scheduleViews.origin.frame.origin.x = scrollView.bounds.size.width
        scheduleViews.origin.reloadData()
        
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
        
        modeDidChange()
        
        highlightView.frame = view.bounds
        highlightView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(highlightView)
        
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.frame.size.width = view.bounds.size.width
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        scrollView.addSubview(scheduleViews.destination)
        scrollView.addSubview(scheduleViews.origin)
        
        view.addSubview(routeLabel)
        view.addSubview(seasonLabel)
        
        directionControl.frame.size.height = directionControl.intrinsicContentSize.height
        directionControl.addTarget(self, action: #selector(changeDirection(sender:)), for: .valueChanged)
        view.addSubview(directionControl)
        
        providerControl.frame.size.height = providerControl.intrinsicContentSize.height
        providerControl.autoresizingMask = [.flexibleTopMargin]
        providerControl.addTarget(self, action: #selector(openProviderURL(sender:)), for: .touchUpInside)
        view.addSubview(providerControl)
        
        popControl.addTarget(self, action: #selector(pop(sender:)), for: .touchUpInside)
        view.addSubview(popControl)
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        directionControl.selectedSegmentIndex = (scrollView.bounds.size.width > 0) ? min(Int(ceil(scrollView.contentOffset.x / scrollView.bounds.size.width)), 1) : 0
        scrollView.setContentOffset(CGPoint(x: (scrollView.bounds.size.width * CGFloat(directionControl.selectedSegmentIndex)), y: 0.0), animated: true)
    }
}
*/

class RouteViewController: ViewController, UINavigationControllerDelegate, UIScrollViewDelegate {
    private static let dateFormatter: DateFormatter = DateFormatter()
    
    var provider: Provider!
    var route: Route!
    
    @IBOutlet var routeLabel: UILabel!
    @IBOutlet var seasonLabel: UILabel!
    @IBOutlet var directionControl: UISegmentedControl!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var providerButton: UIButton!
    @IBOutlet var popButton: UIButton!
    
    @IBAction func changeDirection(_ sender: AnyObject?) {
        print("changeDirection")
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
        } else {
            seasonLabel.text = "Schedule Unavailable"
        }
        directionControl.setTitle("From \(route.origin.name)".uppercased(), forSegmentAt: 0)
        directionControl.setTitle("To \(route.origin.name)".uppercased(), forSegmentAt: 1)
        providerButton.setTitle("Operated by \(provider.name)", for: .normal)
    }
    
    override func modeDidChange() {
        super.modeDidChange()
        
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        routeLabel.textColor = .gray
        scrollView.backgroundColor = .white
        providerButton.setTitleColor(.black, for: .normal)
        popButton.setImage(UIImage(named: "Pop")?.tint(color: .blue), for: .normal)
        popButton.setImage(UIImage(named: "Pop")?.tint(color: UIColor.blue.withAlphaComponent(0.25)), for: .highlighted)
        
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
    }
    
    // MARK: UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return RouteViewAnimator(operation: operation)
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
}

protocol RouteViewDelegate {
    func routeViewRect(controller: RouteViewController) -> CGRect?
}

class RouteViewAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 0.2
    private let scale: CGFloat = 0.8
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
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? ViewController, let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? ViewController else {
            transitionContext.completeTransition(false)
            return
        }
        let view = transitionContext.containerView
        let pushRect = CGRect(x: 0.0, y: UIApplication.shared.statusBarFrame.size.height, width: view.bounds.size.width, height: view.bounds.size.height - UIApplication.shared.statusBarFrame.size.height)
        var popRect = CGRect(x: 0.0, y: view.bounds.size.height, width: view.bounds.size.width, height: 0.0)
        var animations:(Void) -> Void = { }
        switch self.operation {
        case .push:
            if let controller = toViewController as? RouteViewController, let delegate = fromViewController as? RouteViewDelegate, let rect = delegate.routeViewRect(controller: controller) {
                popRect = rect
            }
            view.backgroundColor = fromViewController.view.backgroundColor
            view.addSubview(fromViewController.view)
            view.addSubview(toViewController.view)
            toViewController.view.frame = popRect
            animations = {
                toViewController.view.frame = pushRect
                fromViewController.view.layer.transform = CATransform3DMakeScale(self.scale, self.scale, 1.0)
                fromViewController.view.layer.opacity = 0.25
            }
        case .pop:
            toViewController.viewDidLayoutSubviews()
            view.backgroundColor = toViewController.view.backgroundColor
            view.addSubview(toViewController.view)
            view.addSubview(fromViewController.view)
            toViewController.view.frame = view.bounds
            toViewController.view.layer.transform = CATransform3DMakeScale(self.scale, self.scale, 1.0)
            toViewController.view.layer.opacity = 0.25
            if let controller = fromViewController as? RouteViewController, let delegate = toViewController as? RouteViewDelegate, let rect = delegate.routeViewRect(controller: controller) {
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
            fromViewController.view.layer.opacity = 1.0
            toViewController.view.layer.transform = CATransform3DIdentity
            toViewController.view.frame = view.bounds
            toViewController.view.layer.opacity = 1.0
            transitionContext.completeTransition(finished)
        })
    }
}

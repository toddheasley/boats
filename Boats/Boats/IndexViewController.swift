import UIKit
import SafariServices
import BoatsKit
import BoatsBot

class IndexViewController: UIViewController, UIScrollViewDelegate, NavigationBarDelegate, IndexViewDelegate, RoutePresentationDelegate {
    @objc func refresh() {
        (presentedViewController as? RouteViewController)?.refresh()
        URLSession.shared.index { index, _ in
            self.scrollView.refreshControl?.endRefreshing()
            self.index = index ?? self.index
        }
    }
    
    private func open(route: Route?, animated: Bool = false) {
        guard let route: Route = route, (presentedViewController as? RouteViewController)?.uri != route.uri else {
            return
        }
        guard let routeViewController: RouteViewController = RouteViewController(route: route.uri) else {
            index.current = nil
            return
        }
        index.current = route
        routeViewController.transitioningDelegate = self
        present(routeViewController, animated: animated, completion: nil)
    }
    
    private let scrollView: UIScrollView = UIScrollView()
    private let navigationBar: NavigationBar = NavigationBar()
    private var indexView: IndexView = IndexView()
    
    private var index: Index = Index() {
        didSet {
            navigationBar.menu = (index.name, index.url)
            navigationBar.title = index.description
            indexView.index = index
            viewDidLayoutSubviews()
            highlight(route: index.current)
        }
    }
    
    @discardableResult private func highlight(route: Route? = nil) -> CGRect? {
        var highlight: CGRect? = indexView.highlight(route: route)
        highlight?.origin.x += indexView.frame.origin.x
        highlight?.origin.y += indexView.frame.origin.y
        return highlight
    }
    
    private func clearHighlighted() {
        indexView.clearHighlighted()
    }
    
    // MARK: UIViewController
    public override var preferredStatusBarStyle : UIStatusBarStyle {
        return Appearance.isDark ? .lightContent : .default
    }
    
    override func viewDidChangeAppearance() {
        super.viewDidChangeAppearance()
        
        view.backgroundColor = .background
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        (scrollView.refreshControl as? RefreshControl)?.contentInset.top = view.safeAreaInsets.top
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.scrollIndicatorInsets.top = view.safeAreaInsets.top + navigationBar.frame.size.height
        scrollView.scrollIndicatorInsets.bottom = view.safeAreaInsets.bottom
        navigationBar.frame.origin.y = view.safeAreaInsets.top
        
        indexView.frame.size.width = scrollView.bounds.size.width
        indexView.frame.size.height = indexView.intrinsicContentSize.height
        indexView.frame.origin.y = navigationBar.frame.origin.y + navigationBar.intrinsicContentSize.height + .edgeInset
        
        scrollView.contentSize.width = scrollView.bounds.size.width
        scrollView.contentSize.height = max((indexView.frame.origin.y + indexView.frame.size.height) + max(view.safeAreaInsets.bottom, 8.0), scrollView.bounds.size.height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        open(route: index.current)
        clearHighlighted()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.refreshControl = RefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.frame = view.bounds
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        
        navigationBar.menu = (index.name, index.url)
        navigationBar.title = index.description
        navigationBar.delegate = self
        navigationBar.showAppearance = true
        navigationBar.autoresizingMask = [.flexibleWidth]
        navigationBar.frame.size.width = view.bounds.size.width
        view.addSubview(navigationBar)
        
        indexView.delegate = self
        indexView.index = index
        scrollView.addSubview(indexView)
        
        setNeedsAppearanceUpdates()
        refresh()
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationBar.contentOffset = scrollView.contentOffset
        indexView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y + (navigationBar.frame.origin.y + navigationBar.frame.size.height + .edgeInset))
    }
    
    // MARK: NavigationBarDelegate
    func openNavigation(bar: NavigationBar, url: URL) {
        present(SFSafariViewController(url: url), animated: true, completion: nil)
    }
    
    func dismissNavigation(bar: NavigationBar) {
        
    }
    
    // MARK: IndexViewDelegate
    func openIndex(view: IndexView, route: Route) {
        open(route: route, animated: true)
    }
    
    // MARK: RoutePresentationDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return RoutePresentationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return RoutePresentationController()
    }
    
    func animationOrigin() -> CGRect? {
        var origin: CGRect? = highlight(route: index.current)
        origin?.origin.y -= scrollView.contentOffset.y
        return origin
    }
}
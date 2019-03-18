import UIKit
import SafariServices
import BoatsKit
import BoatsBot

class RouteViewController: UIViewController, UIScrollViewDelegate, NavigationBarDelegate {
    private(set) var uri: String = Index().routes.first!.uri
    
    @objc func refresh() {
        URLSession.shared.index { index, _ in
            self.scrollView.refreshControl?.endRefreshing()
            self.index = index ?? self.index
        }
    }
    
    convenience init?(route uri: String) {
        self.init()
        guard let route: Route = index.route(uri: uri) else {
            return nil
        }
        self.uri = uri
        navigationBar.menu = (index.name, index.url)
        navigationBar.season = route.schedule()?.season
        navigationBar.title = route.name
    }
    
    private let scrollView: UIScrollView = UIScrollView()
    private let navigationBar: NavigationBar = NavigationBar()
    private var timetableViews: [TimetableView] = []
    private var timer: Timer?
    
    private var index: Index = Index() {
        didSet {
            navigationBar.menu = (index.name, index.url)
            guard let route: Route = index.route(uri: self.uri) else {
                dismiss(animated: true, completion: nil)
                return
            }
            navigationBar.season = route.schedule()?.season
            navigationBar.title = route.name
            for timetableView in timetableViews {
                timetableView.removeFromSuperview()
            }
            timetableViews = []
            for timetable in route.schedule()?.timetables ?? [] {
                let timetableView: TimetableView = TimetableView(timetable: timetable, origin: index.location, destination: route.location)
                timetableViews.append(timetableView)
                scrollView.addSubview(timetableView)
            }
            viewDidLayoutSubviews()
            scrollToHighlighted(animated: true)
        }
    }
    
    private func scrollToHighlighted(animated: Bool = false) {
        scrollViewDidScroll(scrollView)
        guard var rect: CGRect = highlight() else {
            return
        }
        rect.origin.y -= ((scrollView.bounds.size.height - rect.size.height) / 2.0) - (view.safeAreaInsets.bottom * 0.5)
        rect.size.height = scrollView.bounds.size.height
        if rect.origin.y < navigationBar.intrinsicContentSize.height {
            rect.origin.y = 0.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (animated ? 0.25 : 0.0)) {
            self.scrollView.scrollRectToVisible(rect, animated: animated)
        }
    }
    
    @discardableResult private func highlight(date: Date = Date()) -> CGRect? {
        clearHighlighted()
        guard let timetable: Timetable = index.route(uri: uri)?.schedule()?.timetable(for: Day(date: date)) else {
            return nil
        }
        for timetableView in timetableViews {
            guard timetableView.timetable.days == timetable.days else {
                continue
            }
            if var rect: CGRect = timetableView.highlight(time: Time(date: date)) {
                rect.origin.y += timetableView.frame.origin.y
                return rect
            } else if let rect: CGRect = highlight(date: Calendar.current.startOfDay(for: Date(timeInterval: 86400.0, since: date))) {
                return rect
            }
        }
        return nil
    }
    
    private func clearHighlighted() {
        for timetableView in timetableViews {
            timetableView.clearHighlighted()
        }
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
        
        var y: CGFloat = navigationBar.frame.origin.y + navigationBar.intrinsicContentSize.height + .edgeInset
        for timetableView in timetableViews {
            timetableView.frame.size.width = scrollView.bounds.size.width
            timetableView.frame.size.height = timetableView.intrinsicContentSize.height
            timetableView.frame.origin.y = y
            y += timetableView.frame.size.height
        }
        scrollView.contentSize.width = scrollView.bounds.size.width
        scrollView.contentSize.height = max(y + max(view.safeAreaInsets.bottom, 8.0), scrollView.bounds.size.height)
        highlight()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timer?.invalidate()
        timer = .scheduledTimer(withTimeInterval: 30.0, repeats: true) { _ in
            self.highlight()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalPresentationStyle = .custom
        
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.refreshControl = RefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.frame = view.bounds
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        
        navigationBar.delegate = self
        navigationBar.canDismiss = true
        navigationBar.autoresizingMask = [.flexibleWidth]
        navigationBar.frame.size.width = view.bounds.size.width
        view.addSubview(navigationBar)
        
        setNeedsAppearanceUpdates()
        refresh()
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationBar.contentOffset = scrollView.contentOffset
        let y: CGFloat = navigationBar.frame.origin.y + navigationBar.frame.size.height + .edgeInset
        for timetableView in timetableViews {
            timetableView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y + y)
        }
    }
    
    // MARK: NavigationBarDelegate
    func openNavigation(bar: NavigationBar, url: URL) {
        present(SFSafariViewController(url: url), animated: true, completion: nil)
    }
    
    func dismissNavigation(bar: NavigationBar) {
        dismiss(animated: true)
        index.current = nil
    }
}

import UIKit
import BoatsKit

class RouteViewController: UIViewController, UIScrollViewDelegate, NavigationBarDelegate {
    private(set) var uri: String = Index().routes.first!.uri
    
    func refresh() {
        URLSession.shared.index { index, _ in
            guard let index: Index = index,
                let route: Route = index.route(uri: self.uri) else {
                return
            }
            self.navigationBar.title = index.name
            self.navigationBar.route = route
            for timetableView in self.timetableViews {
                timetableView.removeFromSuperview()
            }
            self.timetableViews = []
            for timetable in route.schedule()?.timetables ?? [] {
                let timetableView: TimetableView = TimetableView(timetable: timetable, origin: index.location, destination: route.location)
                self.timetableViews.append(timetableView)
                self.scrollView.addSubview(timetableView)
            }
            self.viewDidLayoutSubviews()
        }
    }
    
    convenience init?(route uri: String) {
        self.init()
        let index: Index = Index()
        guard let route: Route = index.route(uri: uri) else {
            return nil
        }
        self.uri = uri
        navigationBar.title = index.name
        navigationBar.route = route
    }
    
    private let scrollView: UIScrollView = UIScrollView()
    private let navigationBar: NavigationBar = NavigationBar()
    private var timetableViews: [TimetableView] = []
    
    // MARK: UIViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refresh()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = .background
        
        scrollView.scrollIndicatorInsets.top = view.safeAreaInsets.top + navigationBar.frame.size.height
        scrollView.scrollIndicatorInsets.bottom = view.safeAreaInsets.bottom
        navigationBar.frame.origin.y = view.safeAreaInsets.top
        
        var y: CGFloat = navigationBar.frame.origin.y + navigationBar.intrinsicContentSize.height + (.edgeInset * 1.0)
        for timetableView in timetableViews {
            timetableView.frame.size.width = scrollView.bounds.size.width
            timetableView.frame.size.height = timetableView.intrinsicContentSize.height
            timetableView.frame.origin.y = y
            y += timetableView.frame.size.height
        }
        scrollView.contentSize.width = scrollView.bounds.size.width
        scrollView.contentSize.height = max(y + view.safeAreaInsets.bottom, scrollView.bounds.size.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.frame = view.bounds
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        
        navigationBar.delegate = self
        navigationBar.autoresizingMask = [.flexibleWidth]
        navigationBar.frame.size.width = view.bounds.size.width
        view.addSubview(navigationBar)
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
    func dismissNavigation(bar: NavigationBar) {
        dismiss(animated: true)
    }
}

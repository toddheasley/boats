import UIKit
import BoatsKit
import BoatsBot

class RouteView: MainView, NavigationBarDelegate {
    var isNavigationBarHidden: Bool = false {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let contentSpace: CGFloat = 16.0
    private let navigationBar: NavigationBar = NavigationBar()
    private let seasonLabel: SeasonLabel = SeasonLabel()
    private var timetableViews: [TimetableView] = []
    private let emptyView: EmptyView = EmptyView()
    
    private func scrollToHighlighted(animated: Bool = false) {
        guard !scrollView.isTracking else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.scrollToHighlighted(animated: animated)
            }
            return
        }
        scrollViewDidScroll(scrollView)
        guard var rect: CGRect = highlight() else {
            return
        }
        rect.origin.y += contentView.frame.origin.y
        rect.origin.y -= (scrollView.bounds.size.height - rect.size.height) / 2.0
        rect.size.height = scrollView.bounds.size.height
        DispatchQueue.main.asyncAfter(deadline: .now() + (animated ? 0.5 : 0.0)) { [weak self] in
            self?.scrollView.scrollRectToVisible(rect, animated: animated)
        }
    }
    
    @discardableResult private func highlight(date: Date = Date()) -> CGRect? {
        clearHighlighted()
        guard let timetable: Timetable = index.route?.schedule()?.timetable(for: Day(date: date)) else {
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
    
    // MARK: MainView
    override var index: Index {
        didSet {
            navigationBar.index = index
            seasonLabel.removeFromSuperview()
            for timetableView in timetableViews {
                timetableView.removeFromSuperview()
            }
            emptyView.removeFromSuperview()
            timetableViews = []
            if let route: Route = index.route,
                let schedule: Schedule = route.schedule() {
                seasonLabel.season = schedule.season
                contentView.addSubview(seasonLabel)
                for timetable in schedule.timetables {
                    let timetableView: TimetableView = TimetableView(timetable: timetable, origin: index.location, destination: route.location)
                    timetableViews.append(timetableView)
                    contentView.addSubview(timetableView)
                }
            } else {
                contentView.addSubview(emptyView)
            }
            setNeedsLayout()
            layoutIfNeeded()
            scrollToHighlighted(animated: true)
        }
    }
    
    override func layoutSubviews() {
        navigationBar.frame.origin.y = safeAreaInsets.top
        navigationBar.isHidden = isNavigationBarHidden
        
        var contentRect: CGRect = self.contentRect
        seasonLabel.frame.size.width = contentView.bounds.size.width
        seasonLabel.frame.origin.y = isNavigationBarHidden ? contentSpace : navigationBar.intrinsicContentSize.height + (contentSpace * 0.5)
        contentRect.size.height = (seasonLabel.frame.origin.y + seasonLabel.frame.size.height)
        for timetableView in timetableViews {
            timetableView.frame.size.width = contentRect.size.width
            timetableView.frame.size.height = timetableView.intrinsicContentSize.height
            timetableView.frame.origin.x = 0.0
            timetableView.frame.origin.y = contentRect.size.height + contentSpace
            contentRect.size.height = timetableView.frame.origin.y + timetableView.frame.size.height
        }
        emptyView.frame.size.width = contentView.bounds.size.width
        emptyView.frame.origin.y = seasonLabel.frame.origin.y
        contentRect.size.height = max(emptyView.frame.origin.y + emptyView.frame.size.height, contentRect.size.height)
        contentView.frame = contentRect
        super.layoutSubviews()
        
        highlight()
        scrollViewDidScroll(scrollView)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        
        var contentOffset: CGPoint = scrollView.contentOffset
        if !isNavigationBarHidden {
            scrollView.verticalScrollIndicatorInsets.top = max(min(contentOffset.y, navigationBar.frame.size.height), 0.0)
            navigationBar.contentOffset = contentOffset
            contentOffset.y += navigationBar.frame.size.height + contentSpace
        }
        for timetableView in timetableViews {
            timetableView.contentOffset = contentOffset
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        navigationBar.delegate = self
        navigationBar.autoresizingMask = [.flexibleWidth]
        navigationBar.frame.size.width = bounds.size.width
        addSubview(navigationBar)
        
        seasonLabel.frame.size.height = seasonLabel.intrinsicContentSize.height
        
        emptyView.frame.size.height = emptyView.intrinsicContentSize.height * 2.0
    }
    
    // MARK: NavigationBarDelegate
    func navigationBar(_ bar: NavigationBar, didOpen url: URL) {
        delegate?.mainView(self, didOpen: url)
    }
    
    func navigationBarDidOpenList(_ bar: NavigationBar) {
        delegate?.mainViewDidOpenList(self)
    }
    
    func navigationBarDidRefresh(_ bar: NavigationBar) {
        delegate?.mainViewDidRefresh(self)
    }
}

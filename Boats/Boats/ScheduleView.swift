import UIKit
import BoatsKit

@objc protocol ScheduleViewDelegate {
    @objc optional func scheduleViewDidChangeDirection(_ view: ScheduleView)
}

class ScheduleView: UIView, UIScrollViewDelegate, ModeTransitioning {
    private let scrollView: UIScrollView = UIScrollView()
    private let destinationView: ScheduleDirectionView = ScheduleDirectionView(direction: .destination)
    private let originView: ScheduleDirectionView = ScheduleDirectionView(direction: .origin)
    
    @IBOutlet var delegate: ScheduleViewDelegate?
    
    var localization: Localization? {
        set {
            destinationView.localization = newValue
            originView.localization = newValue
        }
        get {
            return destinationView.localization
        }
    }
    
    var schedule: Schedule? {
        set {
            destinationView.schedule = newValue
            originView.schedule = newValue
        }
        get {
            return destinationView.schedule
        }
    }
    
    var direction: Departure.Direction = .destination {
        didSet {
            layoutSubviews()
        }
    }
    
    // MARK: UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.contentSize.width = bounds.size.width * 2.0
        scrollView.contentSize.height = bounds.size.height
        scrollView.setContentOffset(CGPoint(x: direction != .destination ? scrollView.bounds.size.width : 0.0, y: 0.0), animated: true)
        
        destinationView.frame.size.width = scrollView.bounds.size.width
        
        originView.frame.size.width = scrollView.bounds.size.width
        originView.frame.origin.x = destinationView.frame.size.width
    }
    
    override func setUp() {
        super.setUp()
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.frame = bounds
        addSubview(scrollView)
        
        destinationView.autoresizingMask = [.flexibleHeight]
        destinationView.frame.size.height = scrollView.bounds.size.height
        scrollView.addSubview(destinationView)
        
        originView.autoresizingMask = [.flexibleHeight]
        originView.frame.size.height = scrollView.bounds.size.height
        scrollView.addSubview(originView)
        
        transitionMode(duration: 0.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        setUp()
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let direction: Departure.Direction = scrollView.contentOffset.x / scrollView.bounds.size.width < 1.0 ? .destination : .origin
        guard direction != self.direction else {
            return
        }
        self.direction = direction
        delegate?.scheduleViewDidChangeDirection?(self)
    }
    
    // MARK: ModeTransitioning
    func transitionMode(duration: TimeInterval) {
        destinationView.transitionMode(duration: duration)
        originView.transitionMode(duration: duration)
    }
}

fileprivate class ScheduleDirectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ModeTransitioning {
    private var time: Time = Time()
    private var day: Day = Day()
    private var days: [(day: Day, departures: [Departure])] = []
    private var departures: (next: Departure?, last: Departure?) = (nil, nil)
    
    private(set) var direction: Departure.Direction = .destination
    
    var localization: Localization? {
        didSet {
            schedule = schedule ?? nil
        }
    }
    
    var schedule: Schedule? {
        didSet {
            time = Time()
            day = Day(localization: localization, holidays: schedule?.holidays)
            days = []
            if let schedule: Schedule = schedule {
                days = schedule.days.map { day in
                    (day, schedule.departures(day: day, direction: direction))
                }
            }
            departures.next = schedule?.next(day: day, time: time, direction: direction)
            departures.last = schedule?.last(day: day, direction: direction)
            
            reloadData()
        }
    }
    
    required init(direction: Departure.Direction, schedule: Schedule? = nil) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionInset = .zero
        
        super.init(frame: .zero, collectionViewLayout: layout)
        self.direction = direction
        self.schedule = schedule
        
        backgroundColor = .clear
        register(ScheduleDayReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Day")
        register(ScheduleHolidayReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "Holiday")
        register(ScheduleViewCell.self, forCellWithReuseIdentifier: "Cell")
        dataSource = self
        delegate = self
        
        transitionMode(duration: 0.0)
    }
    
    // MARK: UICollectionView
    override var frame: CGRect {
        didSet {
            collectionViewLayout.invalidateLayout()
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        fatalError("init(frame:collectionViewLayout:) has not been implemented")
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days[section].departures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ScheduleViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ScheduleViewCell
        cell.localization = localization
        cell.departure = days[indexPath.section].departures[indexPath.row]
        cell.status = .none
        if days[indexPath.section].day == day {
            if let last: Departure = departures.last, last.time == days[indexPath.section].departures[indexPath.row].time {
                cell.status = .last
            } else if let next: Departure = departures.next, next.time == days[indexPath.section].departures[indexPath.row].time {
                cell.status = .next
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionFooter:
            let view: ScheduleHolidayReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Holiday", for: indexPath) as! ScheduleHolidayReusableView
            view.localization = localization
            view.holidays = schedule?.holidays
            return view
        default:
            let view: ScheduleDayReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Day", for: indexPath) as! ScheduleDayReusableView
            view.day = days[indexPath.section].day
            return view
        }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ScheduleViewCell.size(for: collectionView.bounds.size.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return ScheduleDayReusableView.size(for: collectionView.bounds.size.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return days[section].day == .holiday ? ScheduleHolidayReusableView.size(for: collectionView.bounds.size.width, holidays: schedule?.holidays ?? []) : .zero
    }
    
    // MARK: ModeTransitioning
    func transitionMode(duration: TimeInterval) {
        indicatorStyle = mode.indicatorStyle
        for view in visibleSupplementaryViews(ofKind: UICollectionElementKindSectionHeader) {
            (view as? ModeTransitioning)?.transitionMode(duration: duration)
        }
        for view in visibleSupplementaryViews(ofKind: UICollectionElementKindSectionFooter) {
            (view as? ModeTransitioning)?.transitionMode(duration: duration)
        }
        for cell in visibleCells {
            (cell as? ModeTransitioning)?.transitionMode(duration: duration)
        }
    }
}

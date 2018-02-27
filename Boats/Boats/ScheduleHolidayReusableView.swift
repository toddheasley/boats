import UIKit
import BoatsKit

class ScheduleHolidayReusableView: UICollectionReusableView, ModeTransitioning {
    private static let view: ScheduleHolidayView = ScheduleHolidayView()
    
    static func size(for width: CGFloat, holidays: [Holiday]? = nil) -> CGSize {
        guard let holidays = holidays, !holidays.isEmpty else {
            return .zero
        }
        return CGSize(width: width, height: (view.intrinsicContentSize.height * CGFloat(holidays.count)) + UIEdgeInsets.padding.height)
    }
    
    private let contentView: UIView = UIView()
    private var holidayViews: [ScheduleHolidayView] = []
    
    var localization: Localization? {
        didSet {
            holidays = holidays ?? nil
        }
    }
    
    var holidays: [Holiday]? {
        didSet {
            for holidayView in holidayViews {
                holidayView.removeFromSuperview()
            }
            holidayViews = []
            for (i, holiday) in (holidays ?? []).enumerated() {
                let holidayView: ScheduleHolidayView = ScheduleHolidayView(localization: localization, holiday: holiday)
                holidayView.frame.origin.y = holidayView.frame.size.height * CGFloat(i)
                contentView.addSubview(holidayView)
                
                holidayViews.append(holidayView)
            }
            contentView.frame.size.height = ScheduleHolidayReusableView.view.intrinsicContentSize.height * CGFloat(holidayViews.count)
            layoutSubviews()
        }
    }
    
    // MARK: UICollectionReusableView
    override var intrinsicContentSize: CGSize {
        return ScheduleHolidayReusableView.size(for: ScheduleHolidayReusableView.view.intrinsicContentSize.width, holidays: holidays)
    }
    
    override var frame: CGRect {
        set {
            super.frame = CGRect(x: newValue.origin.x, y: newValue.origin.y, width: max(newValue.size.width, intrinsicContentSize.width), height: max(newValue.size.height, intrinsicContentSize.height))
        }
        get {
            return super.frame
        }
    }
    
    override func setUp() {
        super.setUp()
        
        contentView.autoresizingMask = [.flexibleLeftMargin]
        contentView.frame.size.width = ScheduleHolidayReusableView.view.intrinsicContentSize.width
        contentView.frame.origin.x = bounds.size.width - (contentView.frame.size.width + UIEdgeInsets.padding.right)
        contentView.frame.origin.y = UIEdgeInsets.padding.top
        addSubview(contentView)
        
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
    
    // MARK: ModeTransitioning
    func transitionMode(duration: TimeInterval) {
        for holidayView in holidayViews {
            holidayView.transitionMode(duration: duration)
        }
    }
}

fileprivate class ScheduleHolidayView: UIView, ModeTransitioning {
    static let formatter: DateFormatter = DateFormatter()
    
    private let nameLabel: UILabel = UILabel()
    private let dateLabel: UILabel = UILabel()
    
    var localization: Localization? {
        didSet {
            layoutSubviews()
        }
    }
    
    var holiday: Holiday? {
        didSet {
            layoutSubviews()
        }
    }
    
    convenience init(localization: Localization? = nil, holiday: Holiday) {
        self.init()
        self.localization = localization
        self.holiday = holiday
    }
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200.0, height: 13.0)
    }
    
    override var frame: CGRect {
        set {
            super.frame = CGRect(x: newValue.origin.x, y: newValue.origin.y, width: intrinsicContentSize.width, height: intrinsicContentSize.height)
        }
        get {
            return super.frame
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ScheduleHolidayView.formatter.localization = localization ?? Localization()
        
        nameLabel.text = holiday?.name.uppercased()
        nameLabel.frame.size.width = bounds.size.width - dateLabel.frame.size.width
        
        dateLabel.text = holiday != nil ? ScheduleHolidayView.formatter.string(from: holiday!.date, style: .medium).uppercased() : nil
        dateLabel.frame.origin.x = nameLabel.frame.size.width
    }
    
    override func setUp() {
        super.setUp()
        
        nameLabel.font = .meta
        nameLabel.textAlignment = .left
        nameLabel.frame.size.height = bounds.size.height
        addSubview(nameLabel)
        
        dateLabel.font = nameLabel.font
        dateLabel.textAlignment = .right
        dateLabel.frame.size.width = 76.0
        dateLabel.frame.size.height = bounds.size.height
        addSubview(dateLabel)
        
        transitionMode(duration: 0.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ModeTransitioning
    func transitionMode(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.nameLabel.textColor = .text
            self.dateLabel.textColor = .text
        }
    }
}

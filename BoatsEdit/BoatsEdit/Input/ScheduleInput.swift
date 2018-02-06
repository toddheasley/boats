import Cocoa
import BoatsKit

class ScheduleInput: Input {
    private let statusView: ScheduleStatusView = ScheduleStatusView()
    private let datePicker: SeasonDatePicker = SeasonDatePicker()
    
    var schedule: Schedule? {
        didSet {
            layout()
        }
    }
    
    var timeZone: TimeZone? {
        set {
            datePicker.timeZone = newValue
        }
        get {
            return datePicker.timeZone
        }
    }
    
    convenience init(schedule: Schedule) {
        self.init()
        self.schedule = schedule
    }
    
    // MARK: Input
    override var allowsSelection: Bool {
        return true
    }
    
    override var label: String {
        didSet {
            labelTextField.stringValue = label
        }
    }
    
    override func setUp() {
        super.setUp()
        
        labelTextField.font = .systemFont(ofSize: 13.0)
        
        statusView.frame.size.width = datePicker.frame.size.height
        statusView.frame.size.height = statusView.frame.size.width
        statusView.frame.origin.x = intrinsicContentSize.width - (contentInsets.right + statusView.frame.size.width)
        statusView.frame.origin.y = contentInsets.bottom
        addSubview(statusView)
        
        datePicker.isEnabled = false
        datePicker.frame.origin.x = statusView.frame.origin.x - (datePicker.frame.size.width + 4.0)
        datePicker.frame.origin.y = contentInsets.bottom
        addSubview(datePicker)
    }
    
    override func layout() {
        super.layout()
        
        label = "New Schedule"
        labelTextField.textColor = schedule != nil ? .textColor : .selectedMenuItemColor
        if let schedule = schedule {
            switch schedule.season {
            case .spring:
                label = "Spring"
            case .summer:
                label = "Summer"
            case .fall:
                label = "Fall"
            case .winter:
                label = "Winter"
            case .evergreen:
                label = "Evergreen"
            }
        }
        
        statusView.isHidden = schedule == nil
        statusView.status = ScheduleStatusView.Status(dateInterval: schedule?.season.dateInterval)
        
        datePicker.isHidden = schedule?.season.dateInterval == nil
        datePicker.dateInterval = schedule?.season.dateInterval
    }
}

fileprivate class ScheduleStatusView: NSView {
    enum Status {
        case active
        case caution
        case expired
        case none
        
        init(dateInterval: DateInterval?, date: Date = Date()) {
            self = .active
            if let dateInterval = dateInterval {
                if date > dateInterval.end {
                    self = .expired
                } else if date.addingTimeInterval(604800.0) > dateInterval.end {
                    self = .caution
                } else if !dateInterval.contains(date) {
                    self = .none
                }
            }
        }
    }
    
    private let imageView: NSImageView = NSImageView()
    
    var status: Status = .none {
        didSet {
            layout()
        }
    }
    
    // MARK: NSView
    override func layout() {
        super.layout()
        
        switch status {
        case .active:
            imageView.image = NSImage(named: .statusAvailable)
        case .caution:
            imageView.image = NSImage(named: .statusPartiallyAvailable)
        case .expired:
            imageView.image = NSImage(named: .statusUnavailable)
        case .none:
            imageView.image = NSImage(named: .statusNone)
        }
    }
    
    override init(frame rect: NSRect) {
        super.init(frame: rect)
        
        imageView.autoresizingMask = [.width, .height]
        imageView.frame = bounds
        addSubview(imageView)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

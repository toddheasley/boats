import Cocoa
import BoatsKit

class ScheduleInputView: InputView {
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
    
    // MARK: InputView
    override var allowsSelection: Bool {
        return true
    }
    
    override func setUp() {
        super.setUp()
        
        labelTextField.font = .base(.bold)
        
        statusView.frame.size.width = datePicker.frame.size.height
        statusView.frame.size.height = statusView.frame.size.width
        statusView.frame.origin.x = contentView.bounds.size.width - statusView.frame.size.width
        contentView.addSubview(statusView)
        
        datePicker.isEnabled = false
        datePicker.frame.origin.x = statusView.frame.origin.x - (datePicker.frame.size.width + 4.0)
        contentView.addSubview(datePicker)
        
        contentView.wantsLayer = true
        contentView.layer?.backgroundColor = NSColor.red.withAlphaComponent(0.15).cgColor
        
        statusView.wantsLayer = true
        statusView.layer?.backgroundColor = contentView.layer?.backgroundColor
        
        datePicker.wantsLayer = true
        datePicker.layer?.backgroundColor = contentView.layer?.backgroundColor
        
    }
    
    override func layout() {
        super.layout()
        
        label = "New Schedule"
        labelTextField.textColor = schedule != nil ? .textColor : .selectedMenuItemColor
        if let schedule: Schedule = schedule {
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

private class ScheduleStatusView: NSView {
    enum Status {
        case active
        case caution
        case expired
        case none
        
        init(dateInterval: DateInterval?, date: Date = Date()) {
            self = .active
            if let dateInterval: DateInterval = dateInterval {
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
            imageView.image = NSImage(named: NSImage.statusAvailableName)
        case .caution:
            imageView.image = NSImage(named: NSImage.statusPartiallyAvailableName)
        case .expired:
            imageView.image = NSImage(named: NSImage.statusUnavailableName)
        case .none:
            imageView.image = NSImage(named: NSImage.statusNoneName)
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

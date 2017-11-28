//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class ScheduleInput: Input {
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
    
    override var allowsSelection: Bool {
        return true
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
        
        datePicker.isHidden = schedule?.season.dateInterval == nil
        datePicker.dateInterval = schedule?.season.dateInterval
    }
    
    override func setUp() {
        super.setUp()
        
        labelTextField.font = .systemFont(ofSize: 13.0)
        
        datePicker.isEnabled = false
        datePicker.frame.origin.x = intrinsicContentSize.width - (contentInsets.right + datePicker.frame.size.width)
        datePicker.frame.origin.y = contentInsets.bottom
        addSubview(datePicker)
    }
    
    convenience init(schedule: Schedule) {
        self.init()
        self.schedule = schedule
    }
}

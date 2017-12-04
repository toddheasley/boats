//
// © 2018 @toddheasley
//

import Cocoa
import BoatsKit

class HolidayInput: Input {
    private let datePicker: NSDatePicker = NSDatePicker()
    
    var holiday: Holiday? {
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
    
    convenience init(holiday: Holiday) {
        self.init()
        self.holiday = holiday
    }
    
    // MARK: Input
    override var allowsSelection: Bool {
        return true
    }
    
    override func setUp() {
        super.setUp()
        
        labelTextField.font = .systemFont(ofSize: 13.0)
        
        datePicker.isEnabled = false
        datePicker.isBezeled = false
        datePicker.datePickerStyle = .textFieldDatePickerStyle
        datePicker.datePickerElements = [.yearMonthDayDatePickerElementFlag]
        datePicker.sizeToFit()
        datePicker.frame.size.height = 22.0
        datePicker.frame.origin.x = intrinsicContentSize.width - (contentInsets.right + datePicker.frame.size.width + 2.0)
        datePicker.frame.origin.y = contentInsets.bottom
        addSubview(datePicker)
    }
    
    override func layout() {
        super.layout()
        
        label = holiday?.name ?? "New Holiday"
        labelTextField.textColor = holiday != nil ? .textColor : .selectedMenuItemColor
        
        datePicker.dateValue = holiday?.date ?? Date()
        datePicker.isHidden = holiday == nil
    }
}

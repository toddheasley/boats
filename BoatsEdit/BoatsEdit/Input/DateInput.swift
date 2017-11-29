//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class DateInput: Input {
    private let datePicker: NSDatePicker = NSDatePicker()
    
    var date: Date? {
        set {
            datePicker.dateValue = newValue ?? Date()
        }
        get {
            return datePicker.dateValue
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
    
    override func setUp() {
        super.setUp()
        
        datePicker.isBezeled = false
        datePicker.datePickerStyle = .textFieldDatePickerStyle
        datePicker.datePickerElements = [.yearMonthDayDatePickerElementFlag]
        datePicker.target = self
        datePicker.action = #selector(inputEdited(_:))
        datePicker.sizeToFit()
        datePicker.frame.size.height = 22.0
        datePicker.frame.origin.x = intrinsicContentSize.width - (contentInsets.right + datePicker.frame.size.width + 2.0)
        datePicker.frame.origin.y = contentInsets.bottom
        addSubview(datePicker)
        
        label = "Date"
        timeZone = nil
    }
}

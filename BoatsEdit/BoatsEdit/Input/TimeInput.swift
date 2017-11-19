//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class TimeInput: Input {
    private let datePicker: NSDatePicker = NSDatePicker()
    
    var time: Time? {
        set {
            
        }
        get {
            return nil
        }
    }
    
    var timeZone: TimeZone? {
        set {
            datePicker.timeZone = newValue
            datePicker.dateValue = Date()
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
        datePicker.datePickerElements = [.hourMinuteDatePickerElementFlag]
        datePicker.sizeToFit()
        datePicker.frame.size.height = 22.0
        datePicker.frame.origin.x = intrinsicContentSize.width - (contentInsets.right + datePicker.frame.size.width)
        datePicker.frame.origin.y = contentInsets.bottom
        addSubview(datePicker)
        
        label = "Time"
        timeZone = nil
    }
}

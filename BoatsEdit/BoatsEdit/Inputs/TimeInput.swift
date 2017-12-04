//
// © 2018 @toddheasley
//

import Cocoa
import BoatsKit

class TimeInput: Input {
    private let datePicker: NSDatePicker = NSDatePicker()
    
    var time: Time? {
        set {
            datePicker.dateValue = newValue?.date(timeZone: timeZone) ?? Date()
        }
        get {
            return Time(from: datePicker.dateValue, timeZone: timeZone)
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
    
    // MARK: Input
    override func setUp() {
        super.setUp()
        
        datePicker.isBezeled = false
        datePicker.datePickerStyle = .textFieldDatePickerStyle
        datePicker.datePickerElements = [.hourMinuteDatePickerElementFlag]
        datePicker.target = self
        datePicker.action = #selector(inputEdited(_:))
        datePicker.sizeToFit()
        datePicker.frame.size.height = 22.0
        datePicker.frame.origin.x = intrinsicContentSize.width - (contentInsets.right + datePicker.frame.size.width + 2.0)
        datePicker.frame.origin.y = contentInsets.bottom
        addSubview(datePicker)
        
        label = "Time"
        timeZone = nil
    }
}

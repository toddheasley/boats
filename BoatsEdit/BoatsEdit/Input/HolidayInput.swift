//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class HolidayInput: Input, NSTextFieldDelegate {
    private let datePicker: NSDatePicker = NSDatePicker()
    private let textField: NSTextField = NSTextField()
    
    var holiday: Holiday? {
        set {
            datePicker.dateValue = newValue?.date ?? Date()
            textField.stringValue = newValue?.name ?? ""
        }
        get {
            var holiday: Holiday = Holiday()
            holiday.date = datePicker.dateValue.day(timeZone: timeZone).start
            holiday.name = textField.stringValue
            return holiday
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
    
    var placeholder: String? {
        set {
            textField.placeholderString = newValue
        }
        get {
            return textField.placeholderString
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
        datePicker.sizeToFit()
        datePicker.frame.size.height = 22.0
        datePicker.frame.origin.x = intrinsicContentSize.width - (contentInsets.right + datePicker.frame.size.width)
        datePicker.frame.origin.y = contentInsets.bottom
        addSubview(datePicker)
        
        textField.delegate = self
        textField.frame.size.width = datePicker.frame.origin.x - (contentInsets.left + 14.0)
        textField.frame.size.height = 22.0
        textField.frame.origin.x = contentInsets.left
        textField.frame.origin.y = contentInsets.bottom
        addSubview(textField)
        
        placeholder = "Groundhog Day"
        holiday = nil
    }
    
    convenience init(holiday: Holiday) {
        self.init()
        self.holiday = holiday
    }
    
    // MARK: NSTextFieldDelegate
    override func controlTextDidChange(_ obj: Notification) {
        layout()
    }
}

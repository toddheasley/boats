//
//  BoatsEdit
//  © 2017 @toddheasley
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
            holiday.date = datePicker.dateValue
            holiday.name = textField.stringValue
            return holiday
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
    
    override func layout() {
        super.layout()
        
        datePicker.frame.origin.x = bounds.size.width - (contentInsets.right + datePicker.frame.size.width)
        datePicker.frame.origin.y = contentInsets.bottom
        
        textField.frame.size.width = datePicker.frame.origin.x - (contentInsets.left + 14.0)
        textField.frame.size.height = bounds.size.height - (contentInsets.top + contentInsets.bottom)
        textField.frame.origin.x = contentInsets.left
        textField.frame.origin.y = contentInsets.bottom
        textField.refusesFirstResponder = false
    }
    
    override func setUp() {
        super.setUp()
        
        datePicker.datePickerStyle = .textFieldDatePickerStyle
        datePicker.datePickerElements = [.yearMonthDayDatePickerElementFlag]
        datePicker.sizeToFit()
        addSubview(datePicker)
        
        textField.delegate = self
        textField.refusesFirstResponder = true
        addSubview(textField)
        
        holiday = nil
    }
    
    // MARK: NSTextFieldDelegate
    override func controlTextDidChange(_ obj: Notification) {
        layout()
    }
}

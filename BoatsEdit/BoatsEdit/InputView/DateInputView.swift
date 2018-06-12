import Cocoa
import BoatsKit

class DateInputView: InputView {
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
    
    @objc func handleDate(_ sender: AnyObject?) {
        delegate?.inputViewDidEdit(self)
    }
    
    // MARK: InputView
    override func setUp() {
        super.setUp()
        
        datePicker.isBezeled = false
        datePicker.datePickerStyle = .textField
        datePicker.datePickerElements = [.yearMonthDay]
        datePicker.target = self
        datePicker.action = #selector(handleDate(_:))
        datePicker.sizeToFit()
        datePicker.frame.size.height = 22.0
        datePicker.frame.origin.x = contentView.bounds.size.width - datePicker.frame.size.width
        contentView.addSubview(datePicker)
        
        contentView.frame.size.height = datePicker.frame.size.height - 4.0
        
        label = "Date"
        timeZone = nil
    }
}

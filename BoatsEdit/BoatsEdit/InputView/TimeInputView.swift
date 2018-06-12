import Cocoa
import BoatsKit

class TimeInputView: InputView {
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
    
    @objc func handleTime(_ sender: AnyObject?) {
        delegate?.inputViewDidEdit(self)
    }
    
    // MARK: InputView
    override func setUp() {
        super.setUp()
        
        datePicker.isBezeled = false
        datePicker.datePickerStyle = .textField
        datePicker.datePickerElements = [.hourMinute]
        datePicker.target = self
        datePicker.action = #selector(handleTime(_:))
        datePicker.sizeToFit()
        datePicker.frame.size.height = 22.0
        datePicker.frame.origin.x = contentView.bounds.size.width - datePicker.frame.size.width
        contentView.addSubview(datePicker)
        
        contentView.frame.size.height = datePicker.frame.size.height - 4.0
        
        label = "Time"
        timeZone = nil
    }
}

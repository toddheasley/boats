import Cocoa
import BoatsKit

class DepartureInput: Input {
    private let datePicker: NSDatePicker = NSDatePicker()
    
    var departure: Departure? {
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
    
    convenience init(departure: Departure) {
        self.init()
        self.departure = departure
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
        datePicker.datePickerElements = [.hourMinuteDatePickerElementFlag]
        datePicker.target = self
        datePicker.action = #selector(inputEdited(_:))
        datePicker.sizeToFit()
        datePicker.frame.size.height = 22.0
        datePicker.frame.origin.x = intrinsicContentSize.width - (padding.right + datePicker.frame.size.width + 2.0)
        datePicker.frame.origin.y = padding.bottom
        addSubview(datePicker)
    }
    
    override func layout() {
        super.layout()
        
        label = departure?.direction.rawValue.capitalized ?? "New Departure"
        labelTextField.textColor = departure != nil ? .textColor : .selectedMenuItemColor
        
        datePicker.dateValue = departure?.time.date(timeZone: timeZone) ?? Date()
        datePicker.isHidden = departure == nil
    }
}

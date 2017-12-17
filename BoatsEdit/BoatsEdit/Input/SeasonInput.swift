import Cocoa
import BoatsKit

class SeasonInput: Input, SeasonDatePickerDelegate {
    private let popUpButton: NSPopUpButton = NSPopUpButton()
    private let datePicker: SeasonDatePicker = SeasonDatePicker()
    
    var season: Season? {
        set {
            switch newValue ?? .evergreen {
            case .spring:
                popUpButton.selectItem(at: 1)
            case .summer:
                popUpButton.selectItem(at: 2)
            case .fall:
                popUpButton.selectItem(at: 3)
            case .winter:
                popUpButton.selectItem(at: 4)
            case .evergreen:
                popUpButton.selectItem(at: 0)
            }
            datePicker.dateInterval = newValue?.dateInterval ?? DateInterval(start: Date(), duration: 0.0)
            layout()
        }
        get {
            guard let dateInterval: DateInterval = datePicker.dateInterval else {
                return nil
            }
            switch popUpButton.indexOfSelectedItem {
            case 1:
                return .spring(dateInterval)
            case 2:
                return .summer(dateInterval)
            case 3:
                return .fall(dateInterval)
            case 4:
                return .winter(dateInterval)
            default:
                return .evergreen
            }
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
    override var allowsSelection: Bool {
        return true
    }
    
    override var u: Int {
        return 2
    }
    
    override func inputEdited(_ sender: AnyObject?) {
        layout()
        super.inputEdited(sender)
    }
    
    override func setUp() {
        super.setUp()
        
        popUpButton.addItems(withTitles: [
            "Evergreen",
            "Spring",
            "Summer",
            "Fall",
            "Winter",
        ])
        popUpButton.target = self
        popUpButton.action = #selector(inputEdited(_:))
        popUpButton.sizeToFit()
        popUpButton.frame.size.width = 120.0
        popUpButton.frame.origin.x = contentInsets.left
        popUpButton.frame.origin.y = contentInsets.bottom - 3.0
        addSubview(popUpButton)
        
        datePicker.delegate = self
        datePicker.frame.origin.x = intrinsicContentSize.width - (contentInsets.right + datePicker.frame.size.width)
        datePicker.frame.origin.y = contentInsets.bottom
        addSubview(datePicker)
        
        label = "Season"
        season = nil
    }
    
    override func layout() {
        super.layout()
        
        datePicker.isHidden = popUpButton.indexOfSelectedItem == 0
    }
    
    // MARK: SeasonDatePickerDelegate
    func seasonDidChangeDate(picker: SeasonDatePicker) {
        inputEdited(picker)
    }
}

protocol SeasonDatePickerDelegate {
    func seasonDidChangeDate(picker: SeasonDatePicker)
}

class SeasonDatePicker: NSView {
    private let datePicker: (start: NSDatePicker, end: NSDatePicker) = (NSDatePicker(), NSDatePicker())
    private let textField: NSTextField = NSTextField()
    
    var delegate: SeasonDatePickerDelegate?
    
    var dateInterval: DateInterval? {
        set {
            datePicker.start.dateValue = newValue?.start ?? Date()
            datePicker.end.dateValue = newValue?.end ?? Date()
        }
        get {
            return DateInterval(start: datePicker.start.dateValue, end: max(datePicker.end.dateValue, datePicker.start.dateValue))
        }
    }
    
    var timeZone: TimeZone? {
        set {
            datePicker.start.timeZone = newValue
            datePicker.end.timeZone = newValue
        }
        get {
            return datePicker.start.timeZone
        }
    }
    
    var isEnabled: Bool {
        set {
            datePicker.start.isEnabled = newValue
            datePicker.end.isEnabled = newValue
        }
        get {
            return datePicker.start.isEnabled
        }
    }
    
    @IBAction func dateEdited(_ sender: AnyObject?) {
        delegate?.seasonDidChangeDate(picker: self)
    }
    
    // MARK: NSView
    override init(frame rect: NSRect) {
        super.init(frame: rect)
        
        datePicker.start.isBezeled = false
        datePicker.start.datePickerStyle = .textFieldDatePickerStyle
        datePicker.start.datePickerElements = [.yearMonthDayDatePickerElementFlag]
        datePicker.start.sizeToFit()
        datePicker.start.target = self
        datePicker.start.action = #selector(dateEdited(_:))
        addSubview(datePicker.start)
        
        textField.stringValue = "–"
        textField.alignment = .center
        textField.isEditable = false
        textField.backgroundColor = nil
        textField.isBordered = false
        textField.sizeToFit()
        textField.frame.size.height = 19.0
        textField.frame.origin.x = datePicker.start.frame.size.width
        addSubview(textField)
        
        datePicker.end.isBezeled = false
        datePicker.end.datePickerStyle = datePicker.start.datePickerStyle
        datePicker.end.datePickerElements = datePicker.start.datePickerElements
        datePicker.end.target = self
        datePicker.end.action = #selector(dateEdited(_:))
        datePicker.end.frame.size = datePicker.start.frame.size
        datePicker.end.frame.origin.x = textField.frame.origin.x + textField.frame.size.width
        addSubview(datePicker.end)
        
        frame.size.width = datePicker.end.frame.origin.x + datePicker.end.frame.size.width
        frame.size.height = datePicker.end.frame.size.height
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

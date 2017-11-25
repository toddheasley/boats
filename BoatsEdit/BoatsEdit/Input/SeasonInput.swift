//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class SeasonInput: Input {
    private let popUpButton: NSPopUpButton = NSPopUpButton()
    private let datePicker: (start: NSDatePicker, end: NSDatePicker) = (NSDatePicker(), NSDatePicker())
    private let textField: NSTextField = NSTextField()
    
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
            datePicker.start.dateValue = newValue?.dateInterval?.start ?? Date()
            datePicker.end.dateValue = newValue?.dateInterval?.end ?? Date()
            layout()
        }
        get {
            let dateInterval: DateInterval = DateInterval(start: datePicker.start.dateValue.day(timeZone: timeZone).start, end: datePicker.end.dateValue.day(timeZone: timeZone).end)
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
            datePicker.start.timeZone = newValue
            datePicker.end.timeZone = newValue
        }
        get {
            return datePicker.start.timeZone
        }
    }
    
    override func inputEdited(_ sender: AnyObject?) {
        layout()
        super.inputEdited(sender)
    }
    
    override var allowsSelection: Bool {
        return true
    }
    
    override var u: Int {
        return 2
    }
    
    override func layout() {
        super.layout()
        
        datePicker.end.isHidden = popUpButton.indexOfSelectedItem == 0
        datePicker.end.minDate = Date(timeInterval: 86400.0, since: datePicker.start.dateValue)
        datePicker.end.frame.origin.x = bounds.size.width - (contentInsets.right + datePicker.end.frame.size.width)
        datePicker.end.frame.origin.y = contentInsets.bottom
        
        textField.isHidden = datePicker.end.isHidden
        textField.frame.origin.x = datePicker.end.frame.origin.x - textField.frame.size.width
        textField.frame.origin.y = datePicker.end.frame.origin.y
        
        datePicker.start.isBezeled = datePicker.end.isBezeled
        datePicker.start.isHidden = datePicker.end.isHidden
        datePicker.start.frame.origin.x = textField.frame.origin.x - datePicker.start.frame.size.width
        datePicker.start.frame.origin.y = datePicker.end.frame.origin.y
        
        popUpButton.frame.size.width = datePicker.start.frame.origin.x - (contentInsets.left + 11.0)
        popUpButton.frame.origin.x = contentInsets.left
        popUpButton.frame.origin.y = contentInsets.bottom - 3.0
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
        popUpButton.sizeToFit()
        popUpButton.target = self
        popUpButton.action = #selector(inputEdited(_:))
        addSubview(popUpButton)
        
        datePicker.start.isBezeled = false
        datePicker.start.datePickerStyle = .textFieldDatePickerStyle
        datePicker.start.datePickerElements = [.yearMonthDayDatePickerElementFlag]
        datePicker.start.sizeToFit()
        datePicker.start.target = self
        datePicker.start.action = #selector(inputEdited(_:))
        addSubview(datePicker.start)
        
        datePicker.end.isBezeled = false
        datePicker.end.datePickerStyle = datePicker.start.datePickerStyle
        datePicker.end.datePickerElements = datePicker.start.datePickerElements
        datePicker.end.target = self
        datePicker.end.action = #selector(inputEdited(_:))
        datePicker.end.frame.size = datePicker.start.frame.size
        addSubview(datePicker.end)
        
        textField.stringValue = "–"
        textField.alignment = .center
        textField.isEditable = false
        textField.backgroundColor = nil
        textField.isBordered = false
        textField.sizeToFit()
        textField.frame.size.height = 19.0
        addSubview(textField)
        
        label = "Season"
        season = nil
    }
}

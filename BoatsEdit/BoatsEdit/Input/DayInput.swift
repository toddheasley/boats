//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class DayInput: Input {
    private let datePicker: NSDatePicker = NSDatePicker()
    private let specialButton: NSButton = NSButton(checkboxWithTitle: "Special", target: nil, action: nil)
    private var buttons: [NSButton] = []
    
    var days: [Day] {
        set {
            for (index, day) in Day.all.enumerated() {
                buttons[index].state = newValue.contains(day) ? .on : .off
            }
            specialButton.state = .off
            for day in newValue {
                if let date = day.date {
                    datePicker.dateValue = date
                    specialButton.state = .on
                }
            }
        }
        get {
            var days: [Day] = []
            for (index, day) in Day.all.enumerated() {
                guard buttons[index].state == .on else {
                    continue
                }
                days.append(day)
            }
            if specialButton.state == .on {
                days.append(.special(datePicker.dateValue.day(timeZone: timeZone).start))
            }
            return days
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
    
    @IBAction func select(_ sender: AnyObject? = nil) {
        layout()
    }
    
    override var allowsSelection: Bool {
        return true
    }
    
    override var u: Int {
        return 7
    }
    
    override func layout() {
        super.layout()
        
        datePicker.isHidden = specialButton.state != .on
    }
    
    override func setUp() {
        super.setUp()
        
        for (index, day) in Day.all.enumerated() {
            let button: NSButton = NSButton(checkboxWithTitle: day.rawValue.capitalized, target: self, action: #selector(inputEdited(_:)))
            button.frame.size.width = 120.0
            button.frame.size.height = 22.0
            if index < 5 {
                button.frame.origin.x = intrinsicContentSize.width - (contentInsets.right + (button.frame.size.width * 2.0))
                button.frame.origin.y = intrinsicContentSize.height - (contentInsets.top + (button.frame.size.height * CGFloat(index + 3)))
            } else {
                button.frame.origin.x = intrinsicContentSize.width - (contentInsets.right + button.frame.size.width)
                button.frame.origin.y = intrinsicContentSize.height - (contentInsets.top + (button.frame.size.height * CGFloat(index - 2)))
            }
            addSubview(button)
            buttons.append(button)
        }
        
        specialButton.target = self
        specialButton.action = #selector(select(_:))
        specialButton.frame.size.width = 240.0
        specialButton.frame.size.height = 22.0
        specialButton.frame.origin.x = intrinsicContentSize.width - (contentInsets.right + specialButton.frame.size.width)
        specialButton.frame.origin.y = intrinsicContentSize.height - (contentInsets.top + specialButton.frame.size.height)
        addSubview(specialButton)
        
        datePicker.isBezeled = false
        datePicker.datePickerStyle = .textFieldDatePickerStyle
        datePicker.datePickerElements = [.yearMonthDayDatePickerElementFlag]
        datePicker.sizeToFit()
        datePicker.frame.size.height = 22.0
        datePicker.frame.origin.x = 80.0
        datePicker.frame.origin.y = 0.0
        specialButton.addSubview(datePicker)
        
        label = "Days"
        timeZone = nil
    }
}

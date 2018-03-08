import Cocoa
import BoatsKit

class DayInputView: InputView {
    private let datePicker: NSDatePicker = NSDatePicker()
    private let specialButton: NSButton = NSButton(checkboxWithTitle: "Special", target: nil, action: nil)
    private var buttons: [NSButton] = []
    
    var days: [Day] {
        set {
            for (i, day) in Day.all.enumerated() {
                buttons[i].state = newValue.contains(day) ? .on : .off
            }
            specialButton.state = .off
            for day in newValue {
                if let date: Date = day.date {
                    datePicker.dateValue = date
                    specialButton.state = .on
                }
            }
        }
        get {
            var days: [Day] = []
            for (i, day) in Day.all.enumerated() {
                guard buttons[i].state == .on else {
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
    
    @objc func handleDay(_ sender: AnyObject?) {
        datePicker.isHidden = specialButton.state != .on
        delegate?.inputViewDidEdit(self)
    }
    
    // MARK: InputView
    override func setUp() {
        super.setUp()
        
        contentView.frame.size.height = 130.0 + padding.top
        
        for (i, day) in Day.all.enumerated() {
            let button: NSButton = NSButton(checkboxWithTitle: day.rawValue.capitalized, target: self, action: #selector(handleDay(_:)))
            button.frame.size.width = 120.0
            button.frame.size.height = 22.0
            if i < 5 {
                button.frame.origin.x = contentView.bounds.size.width - (button.frame.size.width * 2.0)
                button.frame.origin.y = contentView.bounds.size.height - (button.frame.size.height * CGFloat(i + 2) + padding.top)
            } else {
                button.frame.origin.x = contentView.bounds.size.width - button.frame.size.width
                button.frame.origin.y = contentView.bounds.size.height - (button.frame.size.height * CGFloat(i - 3) + padding.top)
            }
            contentView.addSubview(button)
            buttons.append(button)
        }
        
        specialButton.target = self
        specialButton.action = #selector(handleDay(_:))
        specialButton.frame.size.width = 240.0
        specialButton.frame.size.height = 22.0
        specialButton.frame.origin.x = contentView.bounds.size.width - specialButton.frame.size.width
        specialButton.frame.origin.y = contentView.bounds.size.height - specialButton.frame.size.height + 2.0
        contentView.addSubview(specialButton)
        
        datePicker.isBezeled = false
        datePicker.target = self
        datePicker.action = #selector(handleDay(_:))
        datePicker.datePickerStyle = .textFieldDatePickerStyle
        datePicker.datePickerElements = [.yearMonthDayDatePickerElementFlag]
        datePicker.sizeToFit()
        datePicker.frame.size.height = 22.0
        datePicker.frame.origin.x = 68.0
        datePicker.frame.origin.y = 0.0
        specialButton.addSubview(datePicker)
        
        label = "Days"
        timeZone = nil
    }
}

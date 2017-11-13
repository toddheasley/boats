//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class DayInput: Input {
    private var buttons: [NSButton] = []
    
    var days: [Day] {
        set {
            for (index, day) in Day.all.enumerated() {
                buttons[index].state = newValue.contains(day) ? .on : .off
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
            return days
        }
    }
    
    var services: [Service] {
        set {
            for (index, service) in Service.all.enumerated() {
                buttons[index].state = newValue.contains(service) ? .on : .off
            }
        }
        get {
            var services: [Service] = []
            for (index, service) in Service.all.enumerated() {
                guard buttons[index].state == .on else {
                    continue
                }
                services.append(service)
            }
            return services
        }
    }
    
    override var u: Int {
        return Day.all.count
    }
    
    override func layout() {
        super.layout()
    }
    
    override func setUp() {
        super.setUp()
        
        for (index, day) in Day.all.enumerated() {
            let button: NSButton = NSButton(checkboxWithTitle: day.rawValue.capitalized, target: nil, action: nil)
            button.frame.size.height = 22.0
            button.frame.origin.x = contentInsets.left
            button.frame.origin.y = contentInsets.top + (CGFloat(Day.all.count - (index + 1)) * button.frame.size.height)
            addSubview(button)
            buttons.append(button)
        }
    }
}


//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class ScheduleInput: Input {
    var schedule: Schedule? {
        didSet {
            layout()
        }
    }
    
    override var allowsSelection: Bool {
        return true
    }
    
    override func layout() {
        super.layout()
        
        label = nil ?? "New Schedule"
        labelTextField.textColor = schedule != nil ? .textColor : .selectedMenuItemColor
    }
    
    override func setUp() {
        super.setUp()
        
        labelTextField.font = .systemFont(ofSize: labelTextField.font!.pointSize)
    }
}


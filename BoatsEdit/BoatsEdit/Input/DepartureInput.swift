//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

fileprivate let formatter: DateFormatter = DateFormatter()

class DepartureInput: Input {
    var departure: Departure? {
        didSet {
            layout()
        }
    }
    
    var localization: Localization {
        set {
            formatter.localization = newValue
        }
        get {
            return formatter.localization
        }
    }
    
    override func layout() {
        super.layout()
        
        if let _ = departure {
            
        } else {
            
        }
        
        label = nil ?? "New Departure"
        labelTextField.textColor = departure != nil ? .textColor : .selectedMenuItemColor
    }
    
    override func setUp() {
        super.setUp()
        
        labelTextField.font = .systemFont(ofSize: labelTextField.font!.pointSize)
    }
}


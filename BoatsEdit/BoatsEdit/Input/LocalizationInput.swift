//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class LocalizationInput: Input {
    private let popUpButton: NSPopUpButton = NSPopUpButton()
    
    var localization: Localization? {
        set {
            popUpButton.selectItem(at: TimeZone.knownTimeZoneIdentifiers.index(of: newValue?.timeZone.identifier ?? TimeZone.current.identifier) ?? 0)
        }
        get {
            guard let timeZone: TimeZone = TimeZone(identifier: TimeZone.knownTimeZoneIdentifiers[popUpButton.indexOfSelectedItem]) else {
                return nil
            }
            return Localization(timeZone: timeZone)
        }
    }
    
    override var allowsSelection: Bool {
        return true
    }
    
    override var u: Int {
        return 2
    }
    
    override func layout() {
        super.layout()
        
        popUpButton.frame.size.width = bounds.size.width - (contentInsets.width - 4.0)
        popUpButton.frame.origin.x = contentInsets.left - 2.0
        popUpButton.frame.origin.y = contentInsets.bottom - 2.0
    }
    
    override func setUp() {
        super.setUp()
        
        popUpButton.addItems(withTitles: TimeZone.knownTimeZoneIdentifiers.map { identifier in
            identifier.replacingOccurrences(of: "_", with: " ").replacingOccurrences(of: "/", with: " - ")
        })
        popUpButton.sizeToFit()
        addSubview(popUpButton)
        
        label = "Localization"
        localization = nil
    }
}
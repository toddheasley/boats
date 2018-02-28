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
    
    // MARK: Input
    
    override func setUp() {
        super.setUp()
        
        popUpButton.addItems(withTitles: TimeZone.knownTimeZoneIdentifiers.map { identifier in
            identifier.replacingOccurrences(of: "_", with: " ").replacingOccurrences(of: "/", with: " - ")
        })
        popUpButton.target = self
        popUpButton.action = #selector(inputEdited(_:))
        popUpButton.sizeToFit()
        addSubview(popUpButton)
        
        label = "Localization"
        localization = nil
    }
    
    override func layout() {
        super.layout()
        
        popUpButton.frame.size.width = bounds.size.width - (padding.width - 4.0)
        popUpButton.frame.origin.x = padding.left - 2.0
        popUpButton.frame.origin.y = padding.bottom - 2.0
    }
}

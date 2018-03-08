import Cocoa
import BoatsKit

class LocalizationInputView: InputView {
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
    
    @objc func handleLocalization(_ sender: AnyObject?) {
        delegate?.inputViewDidEdit(self)
    }
    
    // MARK: InputView
    override func setUp() {
        super.setUp()
        
        popUpButton.addItems(withTitles: TimeZone.knownTimeZoneIdentifiers.map { identifier in
            identifier.replacingOccurrences(of: "_", with: " ").replacingOccurrences(of: "/", with: " - ")
        })
        popUpButton.target = self
        popUpButton.action = #selector(handleLocalization(_:))
        popUpButton.sizeToFit()
        popUpButton.frame.size.width = contentView.bounds.size.width + 4.0
        popUpButton.frame.origin.x = -2.0
        contentView.addSubview(popUpButton)
        
        contentView.frame.size.height = labelTextField.frame.size.height + popUpButton.frame.size.height
        
        label = "Localization"
        localization = nil
    }
}

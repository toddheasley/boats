import Cocoa
import BoatsKit

class URIInput: Input, NSTextFieldDelegate {
    private let textField: NSTextField = NSTextField()
    
    var uri: URI? {
        set {
            textField.stringValue = "\(newValue ?? "")"
        }
        get {
            return URI(resource: textField.stringValue)
        }
    }
    
    // MARK: Input
    
    override func setUp() {
        super.setUp()
        
        textField.delegate = self
        textField.frame.size.width = intrinsicContentSize.width - padding.width
        textField.frame.size.height = 22.0
        textField.frame.origin.x = padding.left
        textField.frame.origin.y = padding.bottom
        addSubview(textField)
        
        label = "URI"
        placeholder = "example"
    }
    
    // MARK: NSTextFieldDelegate
    override func controlTextDidChange(_ obj: Notification) {
        textField.stringValue = "\(URI(resource: textField.stringValue))"
    }
    
    override func controlTextDidEndEditing(_ obj: Notification) {
        inputEdited(textField)
    }
}

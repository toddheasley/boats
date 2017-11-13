//
// © 2017 @toddheasley
//

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
    
    var placeholder: String? {
        set {
            textField.placeholderString = newValue
        }
        get {
            return textField.placeholderString
        }
    }
    
    override func layout() {
        super.layout()
        
        textField.frame.size.width = bounds.size.width - (contentInsets.left + contentInsets.right)
        textField.frame.size.height = bounds.size.height - (contentInsets.top + contentInsets.bottom)
        textField.frame.origin.x = contentInsets.left
        textField.frame.origin.y = contentInsets.bottom
    }
    
    override func setUp() {
        super.setUp()
        
        textField.delegate = self
        textField.refusesFirstResponder = true
        addSubview(textField)
    }
    
    // MARK: NSTextFieldDelegate
    override func controlTextDidChange(_ obj: Notification) {
        textField.stringValue = "\(URI(resource: textField.stringValue))"
    }
}

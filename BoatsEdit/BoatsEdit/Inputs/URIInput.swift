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
    
    // MARK: Input
    override var u: Int {
        return 2
    }
    
    override func setUp() {
        super.setUp()
        
        textField.delegate = self
        textField.frame.size.width = intrinsicContentSize.width - contentInsets.width
        textField.frame.size.height = 22.0
        textField.frame.origin.x = contentInsets.left
        textField.frame.origin.y = contentInsets.bottom
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

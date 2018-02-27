import Cocoa

class StringInput: Input, NSTextFieldDelegate {
    private let textField: NSTextField = NSTextField()
    
    var string: String? {
        set {
            textField.stringValue = newValue?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        }
        get {
            return !textField.stringValue.isEmpty ? textField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines) : nil
        }
    }
    
    override var placeholder: String? {
        set {
            textField.placeholderString = newValue
        }
        get {
            return textField.placeholderString
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
        
        label = "String"
    }
    
    // MARK: NSTextFieldDelegate
    override func controlTextDidEndEditing(_ obj: Notification) {
        inputEdited(textField)
    }
}

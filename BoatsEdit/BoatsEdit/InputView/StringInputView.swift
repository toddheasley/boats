import Cocoa

class StringInputView: InputView, NSTextFieldDelegate {
    private let textField: NSTextField = NSTextField()
    
    var string: String? {
        set {
            textField.stringValue = newValue?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        }
        get {
            return !textField.stringValue.isEmpty ? textField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines) : nil
        }
    }
    
    // MARK: InputView
    override var placeholder: String? {
        set {
            textField.placeholderString = newValue
        }
        get {
            return textField.placeholderString
        }
    }
    
    override func setUp() {
        super.setUp()
        
        textField.delegate = self
        textField.frame.size.width = contentView.bounds.size.width
        textField.frame.size.height = 22.0
        contentView.addSubview(textField)
        
        contentView.frame.size.height = labelTextField.frame.size.height + textField.frame.size.height
        
        label = "String"
        string = nil
    }
    
    // MARK: NSTextFieldDelegate
    override func controlTextDidEndEditing(_ obj: Notification) {
        delegate?.inputViewDidEdit(self)
    }
}

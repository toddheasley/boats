import Cocoa
import BoatsKit

class URIInputView: InputView, NSTextFieldDelegate {
    private let textField: NSTextField = NSTextField()
    
    var uri: URI? {
        set {
            textField.stringValue = "\(newValue ?? "")"
        }
        get {
            return URI(resource: textField.stringValue)
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
        
        label = "URI"
        placeholder = "example"
        uri = nil
    }
    
    // MARK: NSTextFieldDelegate
    override func controlTextDidChange(_ obj: Notification) {
        textField.stringValue = "\(URI(resource: textField.stringValue))"
    }
    
    override func controlTextDidEndEditing(_ obj: Notification) {
        delegate?.inputViewDidEdit(self)
    }
}

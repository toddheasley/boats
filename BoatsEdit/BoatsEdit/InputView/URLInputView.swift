import Cocoa
import BoatsKit

class URLInputView: InputView, NSTextFieldDelegate {
    private let previewButton: NSButton = NSButton(title: "Preview", target: nil, action: #selector(preview(_:)))
    private let textField: NSTextField = NSTextField()
    
    var url: URL? {
        set {
            textField.stringValue = newValue?.absoluteString ?? ""
            layout()
        }
        get {
            return URL(string: textField.stringValue)
        }
    }
    
    @IBAction func preview(_ sender: AnyObject? = nil) {
        guard let url: URL = url else {
            return
        }
        NSWorkspace.shared.open(url)
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
    
    override func layout() {
        super.layout()
        
        previewButton.isEnabled = url != nil
    }
    
    override func setUp() {
        super.setUp()
        
        previewButton.target = self
        previewButton.frame.origin.x = contentView.bounds.size.width - (previewButton.frame.size.width - 6.0)
        previewButton.frame.origin.y = -6.0
        contentView.addSubview(previewButton)
        
        textField.delegate = self
        textField.frame.size.width = previewButton.frame.origin.x
        textField.frame.size.height = 22.0
        contentView.addSubview(textField)
        
        contentView.frame.size.height = labelTextField.frame.size.height + textField.frame.size.height
        
        label = "URL"
        placeholder = "https://example.com"
        url = nil
    }
    
    // MARK: NSTextFieldDelegate
    override func controlTextDidChange(_ obj: Notification) {
        layout()
    }
    
    override func controlTextDidEndEditing(_ obj: Notification) {
        delegate?.inputViewDidEdit(self)
    }
}

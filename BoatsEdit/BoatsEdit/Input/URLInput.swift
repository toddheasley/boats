//
// © 2017 @toddheasley
//

import Cocoa

class URLInput: Input, NSTextFieldDelegate {
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
    
    var placeholder: String? {
        set {
            textField.placeholderString = newValue
        }
        get {
            return textField.placeholderString
        }
    }
    
    @IBAction func preview(_ sender: AnyObject? = nil) {
        guard let url: URL = url else {
            return
        }
        NSWorkspace.shared.open(url)
    }
    
    override func layout() {
        super.layout()
        
        previewButton.isEnabled = url != nil
        previewButton.frame.origin.x = bounds.size.width - (contentInsets.right + previewButton.frame.size.width - 6.0)
        previewButton.frame.origin.y = contentInsets.bottom - 6.5
        
        textField.frame.size.width = previewButton.frame.origin.x - (contentInsets.left + 8.0)
        textField.frame.size.height = bounds.size.height - (contentInsets.top + contentInsets.bottom)
        textField.frame.origin.x = contentInsets.left
        textField.frame.origin.y = contentInsets.bottom
        
        textField.refusesFirstResponder = false
    }
    
    override func setUp() {
        super.setUp()
        
        previewButton.target = self
        addSubview(previewButton)
        
        textField.delegate = self
        textField.refusesFirstResponder = true
        addSubview(textField)
    }
    
    // MARK: NSTextFieldDelegate
    override func controlTextDidChange(_ obj: Notification) {
        layout()
    }
}

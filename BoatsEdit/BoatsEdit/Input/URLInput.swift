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
    
    override var u: Int {
        return 2
    }
    
    override func layout() {
        super.layout()
        
        previewButton.isEnabled = url != nil
    }
    
    override func setUp() {
        super.setUp()
        
        previewButton.target = self
        previewButton.frame.origin.x = intrinsicContentSize.width - (contentInsets.right + previewButton.frame.size.width - 6.0)
        previewButton.frame.origin.y = contentInsets.bottom - 6.5
        addSubview(previewButton)
        
        textField.delegate = self
        textField.refusesFirstResponder = true
        textField.frame.size.width = previewButton.frame.origin.x - (contentInsets.left + 6.0)
        textField.frame.size.height = 22.0
        textField.frame.origin.x = contentInsets.left
        textField.frame.origin.y = contentInsets.bottom
        addSubview(textField)
        
        label = "URL"
        placeholder = "https://example.com"
    }
    
    // MARK: NSTextFieldDelegate
    override func controlTextDidChange(_ obj: Notification) {
        layout()
    }
}

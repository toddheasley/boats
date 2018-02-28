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
    
    @IBAction func preview(_ sender: AnyObject? = nil) {
        guard let url: URL = url else {
            return
        }
        NSWorkspace.shared.open(url)
    }
    
    // MARK: Input    
    override func setUp() {
        super.setUp()
        
        previewButton.target = self
        previewButton.frame.origin.x = intrinsicContentSize.width - (padding.right + previewButton.frame.size.width - 6.0)
        previewButton.frame.origin.y = padding.bottom - 6.5
        addSubview(previewButton)
        
        textField.delegate = self
        textField.frame.size.width = previewButton.frame.origin.x - (padding.left + 6.0)
        textField.frame.size.height = 22.0
        textField.frame.origin.x = padding.left
        textField.frame.origin.y = padding.bottom
        addSubview(textField)
        
        label = "URL"
        placeholder = "https://example.com"
    }
    
    override func layout() {
        super.layout()
        
        previewButton.isEnabled = url != nil
    }
    
    // MARK: NSTextFieldDelegate
    override func controlTextDidChange(_ obj: Notification) {
        layout()
    }
    
    override func controlTextDidEndEditing(_ obj: Notification) {
        inputEdited(textField)
    }
}

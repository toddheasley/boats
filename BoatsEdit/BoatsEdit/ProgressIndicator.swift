import Cocoa

class ProgressIndicator: NSView {
    private(set) var isAnimating: Bool = false
    
    func startAnimating() {
        isAnimating = true
    }
    
    func stopAnimating(success: Bool = false) {
        isAnimating = false
    }
    
    private var contentView: NSView!
    
    // MARK: NSView
    override var intrinsicContentSize: NSSize {
        return CGSize(width: 240.0, height: 22.0)
    }
    
    override var frame: NSRect {
        set {
            super.frame = NSRect(x: newValue.origin.x, y: newValue.origin.y, width: max(newValue.size.width, intrinsicContentSize.width), height: max(newValue.size.height, intrinsicContentSize.height))
        }
        get {
            return super.frame
        }
    }
    
    override func layout() {
        super.layout()
        
        contentView.frame.origin.y = (bounds.size.height - contentView.frame.size.height) / 2.0
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        contentView = NSView()
        contentView.autoresizingMask = [.width]
        contentView.frame.size.width = bounds.size.width
        contentView.frame.size.height = intrinsicContentSize.height
        addSubview(contentView)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/*
private var successImageView: NSImageView!
private var successTextField: NSTextField!
private var successView: NSView!

private func displaySuccess(action: Action, for interval: TimeInterval = 3.5) {
    successTextField.stringValue = "\(action.rawValue.capitalized) completed"
    layout()
    successView.isHidden = false
    DispatchQueue.main.asyncAfter(deadline: .now() + max(interval, 0.0)) {
        self.successView.isHidden = true
    }
}
 
 successTextField.sizeToFit()
 successTextField.frame.origin.y = (intrinsicContentSize.height - successTextField.frame.size.height) / 2.0
 
 successView.frame.size.width = successTextField.frame.size.width + successImageView.frame.size.width
 successView.frame.origin.x = bounds.size.width - (successView.frame.size.width + 10.0)
 
 successImageView = NSImageView(image: NSImage(named: NSImage.menuOnStateTemplateName)!)
 successImageView.contentTintColor = .secondaryLabelColor
 successImageView.frame.size.width = 24.0
 successImageView.frame.size.height = intrinsicContentSize.height
 
 successTextField = NSTextField(labelWithString: "")
 successTextField.textColor = successImageView.contentTintColor
 successTextField.frame.origin.x = successImageView.frame.size.width
 
 successView = NSView()
 successView.addSubview(successTextField)
 successView.addSubview(successImageView)
 successView.frame.size.height = intrinsicContentSize.height
 successView.isHidden = true
 addSubview(successView)
 
 */

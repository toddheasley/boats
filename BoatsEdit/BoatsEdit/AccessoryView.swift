import Cocoa
import BoatsKit
import BoatsWeb

protocol AccessoryViewDelegate {
    var directoryURL: URL? {
        get
    }
    
    func directoryFailed(error: Error)
}

class AccessoryView: NSView {
    typealias Action = URLSession.Action
    var delegate: AccessoryViewDelegate?
    
    @objc func fetch() {
        handle(action: .fetch)
    }
    
    @objc func build() {
        handle(action: .build)
    }
    
    @objc func toggleWeb() {
        UserDefaults.standard.web = webButton.state
        guard !isActive,
            let url: URL = delegate?.directoryURL,
            let index: Index = try? Index(from: url) else {
            return
        }
        switch webButton.state {
        case .on:
            try? Site(index: index).build(to: url)
        default:
            try? Site(index: index).delete(from: url)
        }
    }
    
    convenience init(delegate: AccessoryViewDelegate) {
        self.init(frame: .zero)
        self.delegate = delegate
    }
    
    private var fetchButton: NSButton!
    private var buildButton: NSButton!
    private var webButton: NSButton!
    private var progressIndicator: NSProgressIndicator!
    private var successImageView: NSImageView!
    private var successTextField: NSTextField!
    private var successView: NSView!
    
    private var isActive: Bool = false {
        didSet {
            isActive ? progressIndicator.startAnimation(nil) : progressIndicator.stopAnimation(nil)
        }
    }
    
    private func displaySuccess(action: Action, for interval: TimeInterval = 3.5) {
        successTextField.stringValue = "\(action.rawValue.capitalized) completed"
        layout()
        successView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + max(interval, 0.0)) {
            self.successView.isHidden = true
        }
    }
    
    private func handle(action: Action) {
        guard !isActive else {
            return
        }
        isActive = true
        URLSession.shared.index(action: action) { [weak self] index, error in
            do {
                self?.isActive = false
                guard let url: URL = self?.delegate?.directoryURL,
                    let index: Index = index else {
                    throw(error ?? NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: nil))
                }
                try (index as Resource).build(to: url)
                self?.toggleWeb()
                self?.displaySuccess(action: action)
            } catch {
                self?.delegate?.directoryFailed(error: error)
            }
        }
    }
    
    // MARK: NSView
    override var intrinsicContentSize: NSSize {
        return CGSize(width: 420.0, height: 44.0)
    }
    
    override var frame: NSRect {
        set {
            super.frame = NSRect(x: newValue.origin.x, y: newValue.origin.y, width: max(newValue.size.width, intrinsicContentSize.width), height: intrinsicContentSize.height)
        }
        get {
            return super.frame
        }
    }
    
    override func layout() {
        super.layout()
        
        progressIndicator.frame.origin.x = bounds.size.width - (progressIndicator.frame.size.width + 10.0)
        
        successTextField.sizeToFit()
        successTextField.frame.origin.y = (intrinsicContentSize.height - successTextField.frame.size.height) / 2.0
        
        successView.frame.size.width = successTextField.frame.size.width + successImageView.frame.size.width
        successView.frame.origin.x = bounds.size.width - (successView.frame.size.width + 10.0)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        fetchButton = NSButton(title: "Fetch", target: self, action: #selector(fetch))
        fetchButton.frame.size.width += 16.0
        fetchButton.frame.origin.x = 4.0
        fetchButton.frame.origin.y = 4.0
        addSubview(fetchButton)
        
        buildButton = NSButton(title: "Build", target: self, action: #selector(build))
        buildButton.frame.size.width += 20.0
        buildButton.frame.origin.x = fetchButton.frame.size.width
        buildButton.frame.origin.y = fetchButton.frame.origin.y
        addSubview(buildButton)
        
        webButton = NSButton(checkboxWithTitle: "Generate Web Files", target: self, action: #selector(toggleWeb))
        webButton.state = UserDefaults.standard.web
        webButton.frame.origin.x = (buildButton.frame.origin.x + buildButton.frame.size.width) + 3.0
        webButton.frame.origin.y = (intrinsicContentSize.height - (webButton.frame.size.height + 1.0)) / 2.0
        addSubview(webButton)
        
        progressIndicator = NSProgressIndicator()
        progressIndicator.controlSize = .mini
        progressIndicator.isDisplayedWhenStopped = false
        progressIndicator.isIndeterminate = true
        progressIndicator.frame.size.width = 210.0
        progressIndicator.frame.size.height = 41.0
        addSubview(progressIndicator)
        
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
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

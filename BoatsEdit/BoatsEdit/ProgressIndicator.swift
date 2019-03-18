import Cocoa

class ProgressIndicator: NSView {
    var isAnimating: Bool = false {
        didSet {
            progressImageView.isHidden = !isAnimating
            timer?.invalidate()
            guard isAnimating else {
                return
            }
            timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] timer in
                if self?.progressImageView.frame.origin.x == 0.0 {
                    self?.progressImageView.frame.origin.x = -20.0
                } else {
                    self?.progressImageView.frame.origin.x += 2.0
                }
            }
        }
    }
    
    private var progressView: NSView!
    private var progressImageView: NSImageView!
    private var timer: Timer?
    
    // MARK: NSView
    override var intrinsicContentSize: NSSize {
        return CGSize(width: 240.0, height: 21.0)
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
        
        progressView.layer?.backgroundColor = NSColor.gray.withAlphaComponent(0.15).cgColor
        progressView.layer?.borderColor = NSColor.quaternaryLabelColor.withAlphaComponent(NSWorkspace.shared.accessibilityDisplayShouldIncreaseContrast ? 1.0 : 0.2).cgColor
        progressView.layer?.borderWidth = NSWorkspace.shared.accessibilityDisplayShouldIncreaseContrast ? 0.75 : 0.5
        progressView.frame.origin.x = (bounds.size.width - progressView.frame.size.width) / 2.0
        progressView.frame.origin.y = (bounds.size.height - (progressView.frame.size.height + 1.0)) / 2.0
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        progressView = NSView()
        progressView.frame.size.width = intrinsicContentSize.width - 2.0
        progressView.frame.size.height = 13.0
        progressView.wantsLayer = true
        progressView.layer?.cornerRadius = 3.5
        addSubview(progressView)
        
        progressImageView = NSImageView(image: .progress)
        progressImageView.contentTintColor = .controlAccentColor
        progressImageView.frame.size.width = 340.0
        progressImageView.frame.size.height = 13.0
        progressImageView.imageScaling = .scaleProportionallyDown
        progressImageView.isHidden = true
        progressView.addSubview(progressImageView)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NSImage {
    fileprivate static var progress: NSImage {
        return NSImage(named: NSImage.Name("Progress"))!
    }
}

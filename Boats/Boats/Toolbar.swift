import UIKit

@objc protocol ToolbarDelegate {
    @objc optional func toolbar(_ toolbar: Toolbar, didOpen url: URL)
    @objc optional func toolbarDidChange(_ toolbar: Toolbar)
    @objc optional func toolbarDidFinish(_ toolbar: Toolbar)
}

class Toolbar: UIView, ModeTransitioning {
    enum SeparatorPosition {
        case top
        case bottom
        case none
    }
    
    private let backgroundView: UIView = UIView()
    private let separatorView: UIView = UIView()
    let contentView: UIView = UIView()
    
    @IBOutlet var delegate: ToolbarDelegate?
    
    var separatorPosition: SeparatorPosition = .none {
        didSet {
            layoutSubviews()
        }
    }
    
    var isBackgroundHidden: Bool {
        set {
            backgroundView.isHidden = newValue
        }
        get {
            return backgroundView.isHidden
        }
    }
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 44.0)
    }
    
    override var frame: CGRect {
        set {
            super.frame = CGRect(x: newValue.origin.x, y: newValue.origin.y, width: max(newValue.size.width, intrinsicContentSize.width), height: max(newValue.size.height, intrinsicContentSize.height))
        }
        get {
            return super.frame
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch separatorPosition {
        case .top:
            separatorView.frame.origin.y = 0.0
            separatorView.isHidden = false
            contentView.frame.origin.y = UIEdgeInsets.padding.top
        case .bottom:
            separatorView.frame.origin.y = backgroundView.bounds.size.height - separatorView.frame.size.height
            separatorView.isHidden = false
            contentView.frame.origin.y = bounds.size.height - (contentView.frame.size.height + UIEdgeInsets.padding.bottom)
        case .none:
            separatorView.isHidden = true
            contentView.frame.origin.y = (bounds.size.height - contentView.frame.size.height) / 2.0
        }
        contentView.frame.size.width = bounds.size.width - UIEdgeInsets.padding.width
        contentView.frame.origin.x = UIEdgeInsets.padding.left
    }
    
    override func setUp() {
        super.setUp()
        
        backgroundView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        backgroundView.frame = bounds
        addSubview(backgroundView)
        
        separatorView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth]
        separatorView.frame.size.width = bounds.size.width
        separatorView.frame.size.height = .separatorHeight
        backgroundView.addSubview(separatorView)
        
        contentView.frame.size.height = intrinsicContentSize.height - UIEdgeInsets.padding.height
        addSubview(contentView)
        
        transitionMode(duration: 0.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        setUp()
    }
    
    // MARK: ModeTransitioning
    func transitionMode(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.backgroundView.backgroundColor = .background
            self.separatorView.backgroundColor = .separator
        }
    }
}
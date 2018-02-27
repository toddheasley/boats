import UIKit
import BoatsKit

class ProviderView: UIControl, ModeTransitioning {
    private let contentView: UIView = UIView()
    private let label: UILabel = UILabel()
    
    var provider: Provider? {
        didSet {
            layoutSubviews()
        }
    }
    
    convenience init(provider: Provider) {
        self.init(frame: .zero)
        self.provider = provider
    }
    
    // MARK: UIControl
    override var isHighlighted: Bool {
        set {
            super.isHighlighted = newValue
            contentView.layer.backgroundColor = isHighlighted && provider?.url != nil ? UIColor.tint.cgColor : nil
        }
        get {
            return super.isHighlighted
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 32.0)
    }
    
    override var frame: CGRect {
        set {
            super.frame = CGRect(x: newValue.origin.x, y: newValue.origin.y, width: max(newValue.size.width, intrinsicContentSize.width), height: max(newValue.size.height, intrinsicContentSize.height))
        }
        get {
            return super.frame
        }
    }
    
    override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        guard let _ = provider?.url else {
            return
        }
        super.sendAction(action, to: target, for: event)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let provider = provider {
            label.text = "Operated by \(provider.name)"
        } else {
            label.text = nil
        }
        label.frame.origin.x = 4.0
        label.frame.size.width = min(bounds.size.width - (label.frame.origin.x * 2.0), label.sizeThatFits(bounds.size).width)
        contentView.frame.size.width = label.text != nil ? label.frame.size.width + (label.frame.origin.x * 2.0) : bounds.size.width
        contentView.frame.origin.y = (bounds.size.height - contentView.frame.size.height) / 2.0
    }
    
    override func setUp() {
        super.setUp()
        
        isEnabled = false
        
        contentView.isUserInteractionEnabled = false
        contentView.layer.cornerRadius = .cornerRadius
        contentView.frame.size.height = intrinsicContentSize.height
        contentView.frame.origin.x = -4.0
        addSubview(contentView)
        
        label.font = .base
        label.frame.size.height = contentView.bounds.size.height
        contentView.addSubview(label)
        
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
            self.label.textColor = .text
        }
    }
}

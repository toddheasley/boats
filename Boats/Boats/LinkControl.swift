import UIKit

class LinkControl: NavigationControl {
    var text: String? {
        set {
            label.text = newValue
            setNeedsLayout()
            layoutIfNeeded()
        }
        get {
            return label.text
        }
    }
    
    var url: URL? {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    convenience init(text: String, url: URL? = nil) {
        self.init(frame: .zero)
        self.text = text
        self.url = url
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let indicatorView: UIView = UIView()
    private let label: UILabel = UILabel()
    
    // MARK: NavigationControl
    override var accessibilityLabel: String? {
        set {
            super.accessibilityLabel = newValue
        }
        get {
            return super.accessibilityLabel ?? text
        }
    }
    
    override var accessibilityHint: String? {
        set {
            super.accessibilityHint = newValue
        }
        get {
            return super.accessibilityHint ?? url?.host
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let width: CGFloat = label.sizeThatFits(.zero).width
        return CGSize(width: width > 0.0 ? width + (label.frame.origin.x * 2.0) : 0.0, height: super.intrinsicContentSize.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        accessibilityTraits = url != nil ? .link : .staticText
        
        label.frame.size.width = label.sizeThatFits(.zero).width
        
        indicatorView.frame.size.width = label.frame.size.width
        indicatorView.isHidden = isHighlighted || url == nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        indicatorView.backgroundColor = .label
        indicatorView.frame.size.height = 2.0
        indicatorView.frame.origin.x = 2.5
        indicatorView.frame.origin.y = 31.0
        indicatorView.layer.cornerCurve = .continuous
        indicatorView.layer.cornerRadius = 2.0
        contentView.addSubview(indicatorView)
        
        label.font = .systemFont(ofSize: label.font.pointSize, weight: .bold)
        label.textColor = .label
        label.frame.origin.x = 2.0
        label.frame.origin.y = 2.0
        label.frame.size.height = contentView.bounds.size.height - label.frame.origin.y
        contentView.addSubview(label)
    }
}

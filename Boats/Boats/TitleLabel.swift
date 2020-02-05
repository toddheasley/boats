import UIKit

class TitleLabel: UIView {
    var text: String? {
        set {
            label.text = newValue
        }
        get {
            return label.text
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let label: UILabel = UILabel()
    
    // MARK: UIView
    override var accessibilityLabel: String? {
        set {
            super.accessibilityLabel = newValue
        }
        get {
            return super.accessibilityLabel ?? label.text
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let width: CGFloat = label.sizeThatFits(.zero).width
        return CGSize(width: width > 0.0 ? width + (label.frame.origin.x * 2.0) : 0.0, height: 44.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame.size.width = bounds.size.width - (label.frame.origin.x * 2.0)
        label.frame.origin.y = (bounds.size.height - label.frame.size.height) / 2.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        accessibilityTraits = .staticText
        clipsToBounds = false
        
        label.font = .systemFont(ofSize: 32.0, weight: .bold)
        label.textColor = .label
        label.frame.size.height = intrinsicContentSize.height
        label.frame.origin.x = 2.0
        addSubview(label)
    }
}

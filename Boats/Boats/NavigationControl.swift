import UIKit

class NavigationControl: UIControl {
    let contentView: UIView = UIView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIControl
    override var isHighlighted: Bool {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 44.0)
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
        
        contentView.frame.size.width = intrinsicContentSize.width
        contentView.frame.origin.x = (bounds.size.width - contentView.frame.size.width) / 2.0
        contentView.alpha = isHighlighted ? 0.2 : 1.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        contentView.isUserInteractionEnabled = false
        contentView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        contentView.frame.size.height = intrinsicContentSize.height
        contentView.frame.origin.y = (bounds.size.height - contentView.frame.size.height) / 2.0
        addSubview(contentView)
    }
}

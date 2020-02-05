import UIKit

class DismissControl: NavigationControl {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let indicatorView: UIView = UIView()
    
    // MARK: NavigationControl
    override var accessibilityLabel: String? {
        set {
            super.accessibilityLabel = newValue
        }
        get {
            return super.accessibilityLabel ?? "dismiss routes list"
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 44.0, height: super.intrinsicContentSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        indicatorView.backgroundColor = .tertiaryLabel
        indicatorView.layer.cornerCurve = .continuous
        indicatorView.layer.cornerRadius = 2.5
        indicatorView.frame.size.width = 36.0
        indicatorView.frame.size.height = 5.0
        indicatorView.frame.origin.x = 4.0
        indicatorView.frame.origin.y = 14.0
        contentView.addSubview(indicatorView)
    }
}

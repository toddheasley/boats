import UIKit

class MenuLabel: UIControl {
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
    
    private let contentView: UIView = UIView()
    private let label: UILabel = UILabel()
    private let indicator: UIView = UIView()
    
    // MARK: UIControl
    override var isHighlighted: Bool {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: label.frame.size.width, height: 28.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame.origin.y = (bounds.size.height - contentView.frame.size.height) / 2.0
        
        label.textColor = isHighlighted ? .tint : .color
        label.frame.size.width = label.sizeThatFits(contentView.bounds.size).width
        
        indicator.backgroundColor = label.textColor
        indicator.frame.origin.x = 1.0
        indicator.frame.size.width = label.frame.size.width - (indicator.frame.origin.x * 2.0)
        indicator.isHidden = url == nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.isUserInteractionEnabled = false
        contentView.clipsToBounds = false
        contentView.autoresizingMask = [.flexibleWidth]
        contentView.frame.size.width = bounds.size.width
        contentView.frame.size.height = intrinsicContentSize.height
        addSubview(contentView)
        
        label.font = .systemFont(ofSize: 21.0, weight: .bold)
        label.numberOfLines = 1
        label.frame.size.height = contentView.bounds.size.height
        contentView.addSubview(label)
        
        indicator.frame.size.height = .borderWidth
        indicator.frame.origin.y = contentView.bounds.size.height - 3.0
        contentView.addSubview(indicator)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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
        
        label.textColor = isHighlighted ? .background : .color
        label.frame.size.width = label.sizeThatFits(contentView.bounds.size).width
        
        contentView.backgroundColor = isHighlighted ? .color : nil
        contentView.frame.size.width = min(label.frame.size.width + (label.frame.origin.x * 2.0), bounds.size.width)
        contentView.frame.origin.y = (bounds.size.height - contentView.frame.size.height) / 2.0
        
        indicator.backgroundColor = label.textColor
        indicator.frame.origin.x = label.frame.origin.x + 1.0
        indicator.frame.size.width = label.frame.size.width - 2.0
        indicator.isHidden = url == nil || isHighlighted
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.isUserInteractionEnabled = false
        contentView.clipsToBounds = false
        contentView.layer.cornerRadius = .cornerRadius / 3.0
        contentView.frame.origin.x = -3.0
        contentView.frame.size.height = intrinsicContentSize.height
        addSubview(contentView)
        
        label.font = .systemFont(ofSize: 19.0, weight: .bold)
        label.numberOfLines = 1
        label.frame.size.height = contentView.bounds.size.height
        label.frame.origin.x = 6.0
        contentView.addSubview(label)
        
        indicator.frame.size.height = .borderWidth
        indicator.frame.origin.y = contentView.bounds.size.height - 3.0
        contentView.addSubview(indicator)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

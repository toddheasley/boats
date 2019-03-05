import UIKit

class AppearanceControl: UIView {
    @objc func handleAppearance(_ sender: AnyObject?) {
        guard let appearance: Appearance = (sender as? AppearanceButton)?.appearance else {
            return
        }
        Appearance.shared = appearance
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    private let contentView: UIView = UIView()
    private let nameLabel: UILabel = UILabel()
    private let buttons: (view: UIView, mask: UIView) = (UIView(), UIView())
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return contentView.frame.size
    }
    
    override func updateAppearance() {
        super.updateAppearance()
        
        nameLabel.backgroundColor = .color
        nameLabel.textColor = .background
        
        buttons.view.layer.borderColor = .color
        buttons.view.backgroundColor = .color
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for subview in buttons.view.subviews {
            guard let button: AppearanceButton = subview as? AppearanceButton else {
                continue
            }
            button.isSelected = Appearance.shared == button.appearance
        }
        contentView.frame.size.width = buttons.mask.frame.origin.x + buttons.mask.frame.size.width
        contentView.frame.origin.y = (bounds.size.height - contentView.frame.size.height) / 2.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = .cornerRadius / 3.0
        contentView.frame.size.height = 25.0
        addSubview(contentView)
        
        nameLabel.font = .systemFont(ofSize: 15.0, weight: .bold)
        nameLabel.textAlignment = .center
        nameLabel.text = "Appearance"
        nameLabel.frame.size.width = nameLabel.sizeThatFits(.zero).width + (.edgeInset * 2.0)
        nameLabel.frame.size.height = contentView.bounds.size.height
        contentView.addSubview(nameLabel)
        
        buttons.view.clipsToBounds = true
        buttons.view.layer.borderWidth = .borderWidth
        buttons.view.layer.cornerRadius = contentView.layer.cornerRadius
        var x: CGFloat = contentView.layer.cornerRadius
        buttons.view.frame.size.height = contentView.bounds.size.height
        buttons.view.frame.origin.x = 0.0 - x
        for appearance in Appearance.allCases {
            x += 2.0
            let button: AppearanceButton = AppearanceButton(appearance: appearance)
            button.addTarget(self, action: #selector(handleAppearance(_:)), for: .touchDown)
            button.frame.size.width = 54.0
            button.frame.size.height = buttons.view.bounds.size.height - (.borderWidth * 2.0)
            button.frame.origin.x = x
            button.frame.origin.y = .borderWidth
            buttons.view.addSubview(button)
            x += button.frame.size.width
        }
        buttons.view.frame.size.width = x
        buttons.mask.addSubview(buttons.view)
        
        buttons.mask.clipsToBounds = true
        buttons.mask.frame.size.width = buttons.view.frame.origin.x +  buttons.view.frame.size.width
        buttons.mask.frame.size.height = contentView.bounds.size.height
        buttons.mask.frame.origin.x = nameLabel.frame.size.width + .borderWidth
        contentView.addSubview(buttons.mask)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate class AppearanceButton: UIControl {
    var appearance: Appearance = .auto {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    convenience init(appearance: Appearance) {
        self.init(frame: .zero)
        self.appearance = appearance
    }
    
    private let label: UILabel = UILabel()
    
    // MARK: UIControl
    override var isSelected: Bool {
        set {
            super.isSelected = newValue
            updateAppearance()
        }
        get {
            return super.isSelected
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return label.sizeThatFits(.zero)
    }
    
    override func updateAppearance() {
        super.updateAppearance()
        
        backgroundColor = isSelected || isHighlighted ? .clear : .background
        label.textColor = isSelected || isHighlighted ? .background : .color
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.text = appearance.description.capitalized()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.frame = bounds
        addSubview(label)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

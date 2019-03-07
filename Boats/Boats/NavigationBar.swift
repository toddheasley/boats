import UIKit
import BoatsKit

protocol NavigationBarDelegate {
    func openNavigation(bar: NavigationBar, url: URL)
    func dismissNavigation(bar: NavigationBar)
}

class NavigationBar: UIView {
    var delegate: NavigationBarDelegate?
    
    var contentOffset: CGPoint = .zero {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    var showAppearance: Bool = false {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    var canDismiss: Bool = false {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    var menu: (text: String?, url: URL?) {
        didSet {
            menuLabel.text = menu.text
            menuLabel.url = menu.url
        }
    }
    
    var season: Season? {
        set {
            seasonLabel.season = newValue
        }
        get {
            return seasonLabel.season
        }
    }
    
    var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text
        }
    }
    
    @objc func handleMenu(_ sender: AnyObject?) {
        switch sender {
        case is MenuLabel:
            if let url: URL = menu.url {
                delegate?.openNavigation(bar: self, url: url)
            }
        default:
            self.delegate?.dismissNavigation(bar: self)
        }
    }
    
    private let backgroundView: UIView = UIView()
    private let backgroundSeparator: UIView = UIView()
    private let contentView: UIView = UIView()
    private let menuButton: MenuButton = MenuButton()
    private let menuLabel: MenuLabel = MenuLabel()
    private let appearanceControl: AppearanceControl = AppearanceControl()
    private let seasonLabel: SeasonLabel = SeasonLabel()
    private let titleLabel: UILabel = UILabel()
    
    // MARK: UIView
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return super.hitTest(point, with: event) ?? (backgroundView.alpha > 0.0 ? nil : contentView.hitTest(point, with: event))
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 172.0)
    }
    
    override var frame: CGRect {
        set {
            super.frame = CGRect(x: newValue.origin.x, y: newValue.origin.y, width: newValue.size.width, height: 62.0)
        }
        get {
            return super.frame
        }
    }
    
    override func updateAppearance() {
        super.updateAppearance()
        
        backgroundView.backgroundColor = .background
        backgroundSeparator.backgroundColor = .color
        titleLabel.textColor = .color
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundView.frame.size.height = frame.origin.y + frame.size.height
        backgroundView.frame.origin.y = 0.0 - frame.origin.y
        backgroundView.alpha = min(max((contentOffset.y + frame.size.height - intrinsicContentSize.height) * 0.05, 0.0), 1.0)
        
        contentView.frame.size.width = min(bounds.size.width - (.edgeInset * 2.0), .maxWidth)
        contentView.frame.origin.x = (bounds.size.width - contentView.frame.size.width) / 2.0
        contentView.frame.origin.y = max(0.0 - contentOffset.y, bounds.size.height - intrinsicContentSize.height)
        
        menuButton.frame.origin.x = (contentView.frame.origin.x + contentView.frame.size.width + .edgeInset) - menuButton.frame.size.width
        menuButton.isHidden = !canDismiss
        
        menuLabel.frame.origin.x = 0.0
        menuLabel.frame.size.width = menuButton.frame.origin.x - contentView.frame.origin.x
        menuLabel.frame.origin.x = 0.0
        menuLabel.alpha = min(max(1.0 - (contentOffset.y * 0.02), 0.0), 1.0)
        
        appearanceControl.frame.size.width = contentView.bounds.size.width
        appearanceControl.alpha = menuLabel.alpha
        appearanceControl.isHidden = !showAppearance || season != nil
        
        seasonLabel.frame.size.width = menuLabel.frame.size.width
        seasonLabel.alpha = menuLabel.alpha
        seasonLabel.isHidden = !appearanceControl.isHidden
        
        titleLabel.frame.origin.x = 1.5
        titleLabel.frame.size.width = menuLabel.frame.size.width
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = false
        
        backgroundView.autoresizingMask = [.flexibleWidth]
        backgroundView.frame.size.width = bounds.size.width
        addSubview(backgroundView)
        
        backgroundSeparator.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        backgroundSeparator.frame.size.width = backgroundView.bounds.size.width
        backgroundSeparator.frame.size.height = .borderWidth
        backgroundSeparator.frame.origin.y = backgroundView.bounds.size.height
        backgroundView.addSubview(backgroundSeparator)
        
        contentView.frame.size.height = intrinsicContentSize.height
        addSubview(contentView)
        
        menuButton.addTarget(self, action: #selector(handleMenu(_:)), for: .touchDown)
        menuButton.frame.size.width = menuButton.intrinsicContentSize.width + .edgeInset + 4.0
        menuButton.frame.size.height = bounds.size.height
        addSubview(menuButton)
        
        menuLabel.addTarget(self, action: #selector(handleMenu(_:)), for: .touchUpInside)
        menuLabel.frame.size.height = menuButton.frame.size.height
        contentView.addSubview(menuLabel)
        
        appearanceControl.frame.size.height = appearanceControl.intrinsicContentSize.height
        appearanceControl.frame.origin.y = contentView.bounds.size.height - (bounds.size.height + 20.0)
        contentView.addSubview(appearanceControl)
        
        seasonLabel.frame.size.height = seasonLabel.intrinsicContentSize.height
        seasonLabel.frame.origin.y = appearanceControl.frame.origin.y
        contentView.addSubview(seasonLabel)
        
        titleLabel.font = .systemFont(ofSize: 28.0, weight: .bold)
        titleLabel.frame.size.height = bounds.size.height
        titleLabel.frame.origin.y = contentView.bounds.size.height - titleLabel.frame.size.height
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

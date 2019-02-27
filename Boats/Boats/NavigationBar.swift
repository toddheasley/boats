import UIKit
import BoatsKit

protocol NavigationBarDelegate {
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
    
    var route: Route? {
        didSet {
            seasonLabel.season = route?.schedule()?.season
            routeLabel.text = route?.name
        }
    }
    
    var title: String? {
        set {
            menuLabel.text = newValue
        }
        get {
            return menuLabel.text
        }
    }
    
    @objc func handleMenu() {
        delegate?.dismissNavigation(bar: self)
    }
    
    private let backgroundView: UIView = UIView()
    private let backgroundSeparator: UIView = UIView()
    private let contentView: UIView = UIView()
    private let menuButton: MenuButton = MenuButton()
    private let menuLabel: UILabel = UILabel()
    private let seasonLabel: SeasonLabel = SeasonLabel()
    private let routeLabel: UILabel = UILabel()
    
    // MARK: UIView
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundView.backgroundColor = .background
        backgroundView.frame.size.height = frame.origin.y + frame.size.height
        backgroundView.frame.origin.y = 0.0 - frame.origin.y
        backgroundView.alpha = min(max((contentOffset.y + frame.size.height - intrinsicContentSize.height) * 0.05, 0.0), 1.0)
        backgroundSeparator.backgroundColor = .color
        
        contentView.frame.size.width = min(bounds.size.width - (.edgeInset * 2.0), .maxWidth)
        contentView.frame.origin.x = (bounds.size.width - contentView.frame.size.width) / 2.0
        contentView.frame.origin.y = max(0.0 - contentOffset.y, bounds.size.height - intrinsicContentSize.height)
        
        menuButton.frame.origin.x = (contentView.frame.origin.x + contentView.frame.size.width + .edgeInset) - menuButton.frame.size.width
        
        menuLabel.textColor = .color
        menuLabel.frame.origin.x = 1.0
        menuLabel.frame.size.width = menuButton.frame.origin.x - (menuLabel.frame.origin.x + contentView.frame.origin.x)
        menuLabel.alpha = min(max(1.0 - (contentOffset.y * 0.02), 0.0), 1.0)
        
        seasonLabel.frame.size.width = menuLabel.frame.size.width
        seasonLabel.alpha = menuLabel.alpha
        
        routeLabel.textColor = menuLabel.textColor
        routeLabel.frame.origin.x = menuLabel.frame.origin.x
        routeLabel.frame.size.width = menuLabel.frame.size.width
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
        
        menuButton.addTarget(self, action: #selector(handleMenu), for: .touchUpInside)
        menuButton.frame.size.width = menuButton.intrinsicContentSize.width + .edgeInset
        menuButton.frame.size.height = bounds.size.height
        addSubview(menuButton)
        
        menuLabel.font = .systemFont(ofSize: 21.0, weight: .bold)
        menuLabel.frame.origin.y = 6.0
        menuLabel.frame.size.height = bounds.size.height - menuLabel.frame.origin.y
        contentView.addSubview(menuLabel)
        
        seasonLabel.frame.size.height = seasonLabel.intrinsicContentSize.height
        seasonLabel.frame.origin.y = contentView.bounds.size.height - (bounds.size.height + 20.0)
        contentView.addSubview(seasonLabel)
        
        routeLabel.font = .systemFont(ofSize: 28.0, weight: .bold)
        routeLabel.frame.size.height = bounds.size.height
        routeLabel.frame.origin.y = contentView.bounds.size.height - routeLabel.frame.size.height
        contentView.addSubview(routeLabel)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

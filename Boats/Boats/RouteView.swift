import UIKit
import BoatsKit

class RouteView: UIView, ModeTransitioning {
    enum Style {
        case season
        case origin
    }
    
    static let formatter: DateFormatter = DateFormatter()
    
    private let nameLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    
    private(set) var style: Style = .origin
    
    var localization: Localization? {
        didSet {
            layoutSubviews()
        }
    }
    
    var route: Route? {
        didSet {
            layoutSubviews()
        }
    }
    
    convenience init(style: Style, localization: Localization? = nil, route: Route? = nil) {
        self.init(frame: .zero)
        self.style = style
        self.localization = localization
        self.route = route
    }
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 44.0)
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
        
        if let route = route {
            nameLabel.text = route.name
            switch style {
            case .season:
                if let season = route.schedule()?.season {
                    RouteView.formatter.localization = localization ?? Localization()
                    descriptionLabel.text = "\(RouteView.formatter.string(from: season, style: .medium))"
                } else {
                    descriptionLabel.text = "Schedule Unavailable"
                }
            case .origin:
                descriptionLabel.text = "From \(route.origin.name)"
            }
        } else {
            nameLabel.text = nil
            descriptionLabel.text = nil
        }
    }
    
    override func setUp() {
        super.setUp()
        
        nameLabel.font = .systemFont(ofSize: 19.0, weight: .bold)
        nameLabel.autoresizingMask = [.flexibleWidth]
        nameLabel.frame.size.width = bounds.size.width
        nameLabel.frame.size.height = 22.0
        addSubview(nameLabel)
        
        descriptionLabel.font = .systemFont(ofSize: 14.0, weight: .bold)
        descriptionLabel.autoresizingMask = [.flexibleWidth]
        descriptionLabel.frame.size.width = bounds.size.width
        descriptionLabel.frame.size.height = 22.0
        descriptionLabel.frame.origin.y = nameLabel.frame.size.height
        addSubview(descriptionLabel)
        
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
            self.nameLabel.textColor = .text
            self.descriptionLabel.textColor = .text
        }
    }
}

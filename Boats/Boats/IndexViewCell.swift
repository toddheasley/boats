import UIKit
import BoatsKit

class IndexViewCell: UITableViewCell, ModeTransitioning {
    static func height(for width: CGFloat) -> CGFloat {
        return width < 768.0 ? 156.0 : 99.0
    }
    
    private let separatorView: UIView = UIView()
    private let providerView: ProviderView = ProviderView()
    private let routeView: RouteView = RouteView(style: .origin)
    private let departureView: DepartureView = DepartureView()
    
    var localization: Localization? {
        set {
            departureView.localization = newValue
            route = routeView.route
            transitionMode(duration: 0.0)
        }
        get {
            return departureView.localization
        }
    }
    
    var provider: Provider? {
        set {
            providerView.provider = newValue
            transitionMode(duration: 0.0)
        }
        get {
            return providerView.provider
        }
    }
    
    var route: Route? {
        set {
            routeView.route = newValue
            departureView.departure = newValue?.schedule()?.next(day: Day(localization: localization, holidays: newValue?.schedule()?.holidays))
            departureView.status = .next
            transitionMode(duration: 0.0)
        }
        get {
            return routeView.route
        }
    }
    
    // MARK: UITableViewCell
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: IndexViewCell.height(for: bounds.size.width))
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        backgroundView?.backgroundColor = highlighted ? .tint : .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        backgroundView?.backgroundColor = selected ? .tint : .clear
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame.size.width = bounds.size.width - UIEdgeInsets.padding.width
        contentView.frame.size.height = bounds.size.height - UIEdgeInsets.padding.height
        contentView.frame.origin.x = UIEdgeInsets.padding.left
        contentView.frame.origin.y = UIEdgeInsets.padding.top
        
        backgroundView?.frame.size.width = contentView.frame.size.width + 8.0
        backgroundView?.frame.size.height = contentView.frame.size.height + 8.0
        backgroundView?.frame.origin.x = contentView.frame.origin.x - 4.0
        backgroundView?.frame.origin.y = contentView.frame.origin.y - 4.0
        
        separatorView.frame.origin.x = UIEdgeInsets.padding.left
        separatorView.frame.size.width = bounds.size.width - separatorView.frame.origin.x
        
        providerView.frame.size.width = contentView.bounds.size.width
        routeView.frame.size.width = contentView.bounds.size.width
        
        departureView.frame.size.width = contentView.bounds.size.width
        departureView.frame.origin.y = contentView.bounds.size.height < 100.0 ? 11.0 : 49.0
    }
    
    override func setUp() {
        super.setUp()
        
        selectionStyle = .none
        backgroundColor = .clear
        
        separatorView.frame.size.height = .separatorHeight
        addSubview(separatorView)
        
        providerView.autoresizingMask = [UIView.AutoresizingMask.flexibleTopMargin]
        providerView.frame.origin.y = contentView.bounds.size.height - (providerView.frame.size.height - 5.0)
        contentView.addSubview(providerView)
        
        contentView.addSubview(routeView)
        contentView.addSubview(departureView)
        
        backgroundView = UIView()
        backgroundView?.layer.cornerRadius = .cornerRadius
        
        transitionMode(duration: 0.0)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        setUp()
    }
    
    // MARK: ModeTransitioning
    func transitionMode(duration: TimeInterval) {
        providerView.transitionMode(duration: duration)
        routeView.transitionMode(duration: duration)
        departureView.transitionMode(duration: duration)
        
        UIView.animate(withDuration: duration) {
            self.separatorView.backgroundColor = .separator
        }
    }
}
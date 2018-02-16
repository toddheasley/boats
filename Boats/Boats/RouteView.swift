import UIKit

class RouteView: UIView, ModeTransitioning {
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 0.0)
    }
    
    override func setUp() {
        super.setUp()
        
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
            
        }
    }
}

class RouteViewCell: UITableViewCell, ModeTransitioning {
    private let routeView: RouteView = RouteView()
    
    // MARK: UITableViewCell
    override func setUp() {
        super.setUp()
        
        backgroundColor = .clear
        
        routeView.autoresizingMask = [.flexibleWidth]
        routeView.frame = contentView.bounds
        contentView.addSubview(routeView)
        
        transitionMode(duration: 0.0)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        setUp()
    }
    
    // MARK: ModeTransitioning
    func transitionMode(duration: TimeInterval) {
        routeView.transitionMode(duration: duration)
        
        UIView.animate(withDuration: duration) {
            
        }
    }
}

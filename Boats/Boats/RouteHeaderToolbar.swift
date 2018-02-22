import UIKit
import BoatsKit

class RouteHeaderToolbar: Toolbar {
    private let routeView: RouteView = RouteView(style: .season)
    
    var localization: Localization? {
        set {
            routeView.localization = newValue
        }
        get {
            return routeView.localization
        }
    }
    
    var route: Route? {
        set {
            routeView.route = newValue
        }
        get {
            return routeView.route
        }
    }
    
    // MARK: Toolbar
    override var intrinsicContentSize: CGSize {
        return CGSize(width: routeView.intrinsicContentSize.width, height: routeView.intrinsicContentSize.height + UIEdgeInsets.padding.size.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = UIColor.red.withAlphaComponent(0.15)
    }
    
    override func setUp() {
        super.setUp()
        
        separatorPosition = .bottom
        
        
        
        transitionMode(duration: 0.0)
    }
    
    override func transitionMode(duration: TimeInterval) {
        super.transitionMode(duration: duration)
        
        UIView.animate(withDuration: duration) {
            
        }
    }
}

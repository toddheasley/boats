import UIKit
import BoatsKit

class RouteHeaderToolbar: Toolbar {
    private let routeView: RouteView = RouteView(style: .season)
    private let directionControl: UISegmentedControl = UISegmentedControl(items: ["", ""])
    
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
            
            if let newValue: Route = newValue {
                directionControl.setTitle("From \(newValue.origin.name)".uppercased(), forSegmentAt: 0)
                directionControl.setTitle("To \(newValue.origin.name)".uppercased(), forSegmentAt: 1)
            } else {
                directionControl.setTitle("", forSegmentAt: 0)
                directionControl.setTitle("", forSegmentAt: 1)
            }
        }
        get {
            return routeView.route
        }
    }
    
    var direction: Departure.Direction {
        set {
            directionControl.selectedSegmentIndex = newValue == .destination ? 0 : 1
        }
        get {
            return directionControl.selectedSegmentIndex != 1 ? .destination : .origin
        }
    }
    
    @objc func handleDirectionChange(_ sender: AnyObject?) {
        delegate?.toolbarDidChange?(self)
    }
    
    // MARK: Toolbar
    override var intrinsicContentSize: CGSize {
        return CGSize(width: routeView.intrinsicContentSize.width, height: routeView.intrinsicContentSize.height + 44.0 + UIEdgeInsets.padding.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        directionControl.frame.origin.y = contentView.bounds.size.height - directionControl.frame.size.height
    }
    
    override func setUp() {
        super.setUp()
        
        separatorPosition = .bottom
        
        routeView.autoresizingMask = [.flexibleWidth]
        routeView.frame.size.width = contentView.bounds.size.width
        contentView.addSubview(routeView)
        
        directionControl.setTitleTextAttributes([
            NSAttributedStringKey.font: UIFont.meta
        ], for: .normal)
        directionControl.selectedSegmentIndex = 0
        directionControl.autoresizingMask = [.flexibleWidth]
        directionControl.frame.size.width = contentView.bounds.size.width
        directionControl.frame.size.height = 27.0
        directionControl.addTarget(self, action: #selector(handleDirectionChange(_:)), for: .valueChanged)
        contentView.addSubview(directionControl)
        
        transitionMode(duration: 0.0)
    }
    
    override func transitionMode(duration: TimeInterval) {
        super.transitionMode(duration: duration)
        
        routeView.transitionMode(duration: duration)
        
        UIView.animate(withDuration: duration) {
            self.directionControl.tintColor = .text
        }
    }
}

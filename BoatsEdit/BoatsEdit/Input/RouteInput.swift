//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class RouteInput: Input {
    var route: Route? {
        didSet {
            layout()
        }
    }
    
    convenience init(route: Route) {
        self.init()
        self.route = route
    }
    
    // MARK: Input
    override var allowsSelection: Bool {
        return true
    }
    
    override func setUp() {
        super.setUp()
        
        labelTextField.font = .systemFont(ofSize: 13.0)
    }
    
    override func layout() {
        super.layout()
        
        label = route?.name ?? "New Route"
        labelTextField.textColor = route != nil ? .textColor : .selectedMenuItemColor
    }
}

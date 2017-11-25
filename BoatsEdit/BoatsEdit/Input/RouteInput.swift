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
    
    override var allowsSelection: Bool {
        return true
    }
    
    override func layout() {
        super.layout()
        
        label = route?.name ?? "New Route"
        labelTextField.textColor = route != nil ? .textColor : .selectedMenuItemColor
    }
    
    override func setUp() {
        super.setUp()
        
        labelTextField.font = .systemFont(ofSize: 13.0)
    }
    
    convenience init(route: Route) {
        self.init()
        self.route = route
    }
}

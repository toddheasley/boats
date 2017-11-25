//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class LocationInput: Input {
    private(set) var direction: Departure.Direction = .destination
    
    var location: Location? {
        didSet {
            layout()
        }
    }
    
    override var allowsSelection: Bool {
        return true
    }
    
    override func layout() {
        super.layout()
        
        label = direction.rawValue.capitalized
    }
    
    override func setUp() {
        super.setUp()
        
        labelTextField.font = .systemFont(ofSize: 13.0)
    }
    
    convenience init(direction: Departure.Direction, location: Location? = nil) {
        self.init()
        self.direction = direction
        self.location = location
    }
}



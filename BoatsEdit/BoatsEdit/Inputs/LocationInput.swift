//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class LocationInput: Input {
    private let textField: NSTextField = NSTextField()
    private(set) var direction: Departure.Direction = .destination
    
    var location: Location? {
        didSet {
            textField.stringValue = location?.name ?? ""
        }
    }
    
    convenience init(direction: Departure.Direction, location: Location? = nil) {
        self.init()
        self.direction = direction
        self.location = location
    }
    
    // MARK: Input
    override var allowsSelection: Bool {
        return true
    }
    
    override func setUp() {
        super.setUp()
        
        textField.font = .systemFont(ofSize: 13.0)
        textField.alignment = .right
        textField.backgroundColor = nil
        textField.isEditable = false
        textField.isBordered = false
        textField.frame.size.width = 240.0
        textField.frame.size.height = labelTextField.frame.size.height
        textField.frame.origin.x = bounds.size.width - (contentInsets.left + textField.frame.size.width)
        textField.frame.origin.y = labelTextField.frame.origin.y
        addSubview(textField)
    }
    
    override func layout() {
        super.layout()
        
        label = direction.rawValue.capitalized
    }
}

import Cocoa
import BoatsKit

class LocationInputView: InputView {
    private let textField: NSTextField = NSTextField()
    private(set) var direction: Departure.Direction = .destination
    
    var location: Location? {
        didSet {
            textField.stringValue = location?.name ?? ""
        }
    }
    
    convenience init(direction: Departure.Direction) {
        self.init(style: .label)
        self.direction = direction
    }
    
    // MARK: InputView
    override var allowsSelection: Bool {
        return true
    }
    
    override func layout() {
        super.layout()
        
        label = direction.rawValue.capitalized
    }
    
    override func setUp() {
        super.setUp()
        
        //contentView.frame.size.height = 12.0
        
        textField.font = .base(.bold)
        textField.alignment = .right
        textField.backgroundColor = nil
        textField.isEditable = false
        textField.isBordered = false
        textField.frame.size.width = 240.0
        textField.frame.size.height = 22.0
        textField.frame.origin.x =  intrinsicContentSize.width - (textField.frame.size.width + padding.right)
        textField.frame.origin.y = contentView.frame.origin.y - 5.0
        //addSubview(textField)
        
        //labelTextField.frame.origin.y += 1.0
        
        //textField.stringValue = "Pythagorea"
    }
}

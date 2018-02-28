import Cocoa
import BoatsKit

class ProviderInput: Input {
    var provider: Provider? {
        didSet {
            layout()
        }
    }
    
    convenience init(provider: Provider) {
        self.init()
        self.provider = provider
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
        
        label = provider?.name ?? "New Provider"
        labelTextField.textColor = provider != nil ? .textColor : .selectedMenuItemColor
    }
}

//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class ProviderInput: Input {
    var provider: Provider? {
        didSet {
            layout()
        }
    }
    
    override var allowsSelection: Bool {
        return true
    }
    
    override func layout() {
        super.layout()
        
        label = provider?.name ?? "New Provider"
        labelTextField.textColor = provider != nil ? .textColor : .selectedMenuItemColor
    }
    
    override func setUp() {
        super.setUp()
        
        labelTextField.font = .systemFont(ofSize: 13.0)
    }
    
    convenience init(provider: Provider) {
        self.init()
        self.provider = provider
    }
}

import Cocoa
import BoatsKit

class ProviderInputView: InputView {
    var provider: Provider? {
        didSet {
            
        }
    }
    
    required init(provider: Provider? = nil) {
        super.init(style: .label)
        
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: InputView
    override func setUp() {
        super.setUp()
        
    }
}

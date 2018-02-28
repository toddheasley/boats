import Cocoa

class DividerInput: Input {
    
    private var divider: CALayer?
    
    
    
    // MARK: Input
    
    override func setUp() {
        super.setUp()
        
        labelTextField.removeFromSuperview()
        wantsLayer = true
        
    }
}

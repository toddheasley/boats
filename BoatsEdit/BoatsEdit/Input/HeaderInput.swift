//
// © 2017 @toddheasley
//

import Cocoa

class HeaderInput: Input {
    override var u: Int {
        return 2
    }
    
    override func setUp() {
        super.setUp()
        
        labelTextField.font = NSFont.systemFont(ofSize: 24.0, weight: .heavy)
        labelTextField.textColor = labelTextField.textColor?.withAlphaComponent(0.7)
        labelTextField.frame.size.height *= 2.0
        labelTextField.frame.origin.y = contentInsets.bottom
    }
}

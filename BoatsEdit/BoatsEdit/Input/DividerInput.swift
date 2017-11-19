//
// © 2017 @toddheasley
//

import Cocoa

class DividerInput: Input {
    private let divider: CALayer = CALayer()
    
    override func setUp() {
        super.setUp()
        
        labelTextField.removeFromSuperview()
        wantsLayer = true
        
        divider.backgroundColor = NSColor.gridColor.withAlphaComponent(0.5).cgColor
        divider.cornerRadius = 1.0
        divider.frame.size.width = intrinsicContentSize.width - (contentInsets.width + 4.0)
        divider.frame.size.height = divider.cornerRadius * 2.0
        divider.frame.origin.x = contentInsets.left + 2.0
        divider.frame.origin.y = (intrinsicContentSize.height - 4.0) / 2.0
        layer?.addSublayer(divider)
    }
}


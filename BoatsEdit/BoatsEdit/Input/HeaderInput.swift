//
// © 2017 @toddheasley
//

import Cocoa

class HeaderInput: Input {
    
    let webButton: NSButton = NSButton(checkboxWithTitle: "Include Web Pages", target: nil, action: nil)
    
    override var u: Int {
        return 2
    }
    
    override func layout() {
        super.layout()
        
        webButton.frame.origin.x = (labelTextField.frame.origin.x + labelTextField.frame.size.width) - webButton.frame.size.width
        webButton.frame.origin.y = (labelTextField.frame.origin.y + labelTextField.frame.size.height) - webButton.frame.size.height
    }
    
    override func setUp() {
        super.setUp()
        
        labelTextField.font = NSFont.systemFont(ofSize: 24.0, weight: .heavy)
        labelTextField.textColor = labelTextField.textColor?.withAlphaComponent(0.7)
        labelTextField.frame.size.height *= 2.0
        labelTextField.frame.origin.y = contentInsets.bottom
        
        webButton.isHidden = true
        webButton.alignment = .right
        addSubview(webButton)
        
        webButton.wantsLayer = true
        webButton.layer?.backgroundColor = labelTextField.layer?.backgroundColor
    }
}

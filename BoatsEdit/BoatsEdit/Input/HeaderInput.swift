//
// © 2017 @toddheasley
//

import Cocoa

class HeaderInput: Input {
    let webButton: NSButton = NSButton(checkboxWithTitle: "Include Web Pages", target: nil, action: nil)
    let deleteButton: NSButton = NSButton()
    
    override var u: Int {
        return 2
    }
    
    override func layout() {
        super.layout()
        
        webButton.frame.origin.x = (labelTextField.frame.origin.x + labelTextField.frame.size.width) - webButton.frame.size.width
        deleteButton.frame.origin.x = (labelTextField.frame.origin.x + labelTextField.frame.size.width) - deleteButton.frame.size.width
    }
    
    override func setUp() {
        super.setUp()
        
        labelTextField.font = .systemFont(ofSize: 22.0, weight: .bold)
        labelTextField.textColor = .textColor
        labelTextField.frame.size.height = 27.0
        labelTextField.frame.origin.y = contentInsets.bottom + 7.0
        
        webButton.isHidden = true
        webButton.frame.origin.y = labelTextField.frame.origin.y + 2.0
        addSubview(webButton)
        
        deleteButton.isHidden = true
        deleteButton.image = NSImage(named: NSImage.Name("NSTouchBarDeleteTemplate"))
        deleteButton.isBordered = false
        deleteButton.frame.size.width = labelTextField.frame.size.height
        deleteButton.frame.size.height = labelTextField.frame.size.height
        deleteButton.frame.origin.y = labelTextField.frame.origin.y
        addSubview(deleteButton)
        
        wantsLayer = true
        //layer?.backgroundColor = NSColor.blue.withAlphaComponent(0.15).cgColor
        labelTextField.wantsLayer = true
        labelTextField.layer?.backgroundColor = layer?.backgroundColor
        webButton.wantsLayer = true
        webButton.layer?.backgroundColor = layer?.backgroundColor
        deleteButton.wantsLayer = true
        deleteButton.layer?.backgroundColor = layer?.backgroundColor
    }
}

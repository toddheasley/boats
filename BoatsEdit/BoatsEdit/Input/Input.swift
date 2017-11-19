//
// © 2017 @toddheasley
//

import Cocoa

class Input: NSView {
    let contentInsets: NSEdgeInsets = NSEdgeInsets(top: 14.0, left: 16.0, bottom: 10.0, right: 16.0)
    let labelTextField: NSTextField = NSTextField(labelWithString: "")
    
    var label: String {
        set {
            labelTextField.stringValue = newValue
        }
        get {
            return labelTextField.stringValue
        }
    }
    
    var u: Int {
        return 1
    }
    
    override var intrinsicContentSize: NSSize {
        return NSSize(width: 360.0, height: (22.0 * CGFloat(u)) + (contentInsets.top + contentInsets.bottom))
    }
    
    override var frame: NSRect {
        set {
            super.frame.size = intrinsicContentSize
            super.frame.origin = newValue.origin
        }
        get {
            return super.frame
        }
    }
    
    func setUp() {
        labelTextField.font = .boldSystemFont(ofSize: labelTextField.font!.pointSize)
        labelTextField.frame.size.width = intrinsicContentSize.width - (contentInsets.left + contentInsets.right)
        labelTextField.frame.size.height = 22.0
        labelTextField.frame.origin.x = contentInsets.left + 2.0
        labelTextField.frame.origin.y = intrinsicContentSize.height - (labelTextField.frame.size.height + contentInsets.top)
        addSubview(labelTextField)
    }
    
    override init(frame rect: NSRect) {
        super.init(frame: rect)
        frame = rect
        setUp()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        setUp()
    }
}

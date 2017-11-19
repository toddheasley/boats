//
// © 2017 @toddheasley
//

import Cocoa

class Input: NSView {
    let contentInsets: NSEdgeInsets = NSEdgeInsets(top: 4.0, left: 14.0, bottom: 8.0, right: 14.0)
    let labelTextField: NSTextField = NSTextField(labelWithString: "")
    
    private(set) var allowsSelection: Bool = false
    var isSelected: Bool = false
    
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
        return NSSize(width: 360.0, height: (22.0 * CGFloat(u)) + contentInsets.height)
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
        labelTextField.font = NSFont.systemFont(ofSize: 12.0, weight: .bold)
        labelTextField.textColor = labelTextField.textColor?.withAlphaComponent(0.8)
        labelTextField.frame.size.width = intrinsicContentSize.width - contentInsets.width
        labelTextField.frame.size.height = 17.0
        labelTextField.frame.origin.x = contentInsets.left
        labelTextField.frame.origin.y = intrinsicContentSize.height - (labelTextField.frame.size.height + contentInsets.top + 4.0)
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

extension NSEdgeInsets {
    var width: CGFloat {
        return left + right
    }
    
    var height: CGFloat {
        return top + bottom
    }
}

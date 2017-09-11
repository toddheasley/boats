//
//  BoatsEdit
//  © 2017 @toddheasley
//

import Cocoa

class Input: NSView {
    let contentInsets: NSEdgeInsets = NSEdgeInsets(top: 11.0, left: 22.0, bottom: 11.0, right: 22.0)
    
    override var intrinsicContentSize: NSSize {
        return NSSize(width: 308.0 + (contentInsets.left + contentInsets.right), height: 22.0 + (contentInsets.top + contentInsets.bottom))
    }
    
    override var frame: NSRect {
        set {
            super.frame.size.width = max(newValue.size.width, intrinsicContentSize.width)
            super.frame.size.height = intrinsicContentSize.height
            super.frame.origin = newValue.origin
        }
        get {
            return super.frame
        }
    }
    
    func setUp() {
        wantsLayer = true
        layer?.backgroundColor = NSColor.red.withAlphaComponent(0.1).cgColor
    }
    
    override init(frame rect: NSRect) {
        super.init(frame: rect)
        setUp()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        setUp()
    }
}

//
// © 2017 @toddheasley
//

import Cocoa

class Input: NSView {
    let contentInsets: NSEdgeInsets = NSEdgeInsets(top: 11.0, left: 12.0, bottom: 11.0, right: 12.0)
    
    var u: Int {
        return 1
    }
    
    override var intrinsicContentSize: NSSize {
        return NSSize(width: 340.0, height: (22.0 * CGFloat(u)) + (contentInsets.top + contentInsets.bottom))
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

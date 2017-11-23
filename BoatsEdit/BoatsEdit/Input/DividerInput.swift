//
// © 2017 @toddheasley
//

import Cocoa

class DividerInput: Input {
    enum Style {
        case rule
        case none
    }
    
    private var divider: CALayer?
    
    private(set) var style: Style {
        set {
            divider?.removeFromSuperlayer()
            switch newValue {
            case .rule:
                divider = CALayer()
                divider!.backgroundColor = NSColor.gridColor.withAlphaComponent(0.5).cgColor
                divider!.frame.size.width = intrinsicContentSize.width - (contentInsets.left + 2.0)
                divider!.frame.size.height = 1.0
                divider!.frame.origin.x = intrinsicContentSize.width - divider!.frame.size.width
                divider!.frame.origin.y = (intrinsicContentSize.height - 2.0) / 2.0
                layer?.addSublayer(divider!)
            case .none:
                divider = nil
            }
        }
        get {
            return divider != nil ? .rule : .none
        }
    }
    
    override var u: Int {
        return style == .none ? 0 : 1
    }
    
    override func setUp() {
        super.setUp()
        
        labelTextField.removeFromSuperview()
        wantsLayer = true
        
        style = .rule
    }
    
    convenience init(style: Style) {
        self.init()
        self.style = style
    }
}


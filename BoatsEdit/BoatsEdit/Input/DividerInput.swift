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
                divider!.cornerRadius = 1.0
                divider!.frame.size.width = intrinsicContentSize.width - (contentInsets.width + 4.0)
                divider!.frame.size.height = 2.0
                divider!.frame.origin.x = contentInsets.left + 2.0
                divider!.frame.origin.y = (intrinsicContentSize.height - 4.0) / 2.0
                layer?.addSublayer(divider!)
            case .none:
                divider = nil
            }
        }
        get {
            return divider != nil ? .rule : .none
        }
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


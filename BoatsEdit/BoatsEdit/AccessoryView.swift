import Cocoa
import BoatsKit

protocol AccessoryViewDelegate {
    func directory(for action: AccessoryView.Action) -> URL?
}

class AccessoryView: NSView {
    typealias Action = URLSession.Action
    var delegate: AccessoryViewDelegate?
    
    convenience init(delegate: AccessoryViewDelegate) {
        self.init(frame: .zero)
        self.delegate = delegate
    }
    
    // MARK: NSView
    override var intrinsicContentSize: NSSize {
        return CGSize(width: 88.0, height: 44.0)
    }
    
    override var frame: NSRect {
        set {
            super.frame = NSRect(x: newValue.origin.x, y: newValue.origin.y, width: max(newValue.size.width, intrinsicContentSize.width), height: max(newValue.size.height, intrinsicContentSize.height))
        }
        get {
            return super.frame
        }
    }
    
    override func layout() {
        super.layout()
        
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

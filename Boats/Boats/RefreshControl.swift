import UIKit

class RefreshControl: UIRefreshControl {
    var contentInset: UIEdgeInsets {
        set {
            if newValue.top != y  {
                y = newValue.top
            }
        }
        get {
            return UIEdgeInsets(top: y, left: 0.0, bottom: 0.0, right: 0.0)
        }
    }
    
    private var y: CGFloat = 0.0
    
    // MARK: UIRefreshControl
    override var frame: CGRect {
        set {
            super.frame = CGRect(x: newValue.origin.x, y: newValue.origin.y + y, width: newValue.size.width, height: newValue.size.height)
        }
        get {
            return super.frame
        }
    }
    
    override func updateAppearance() {
        super.updateAppearance()
        
        tintColor = .color
    }
}

import UIKit

class RefreshControl: UIRefreshControl {
    
    // MARK: UIRefreshControl
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.red.withAlphaComponent(0.2)
        for subview in subviews {
            subview.isHidden = true
        }
    }
}

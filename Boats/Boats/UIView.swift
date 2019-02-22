import UIKit

extension UIView {
    func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    func layout() {
        setNeedsLayout()
        layoutIfNeeded()
    }
}

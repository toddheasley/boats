import UIKit

extension UIView {
    @objc public func updateAppearance() {
        for subview in subviews {
            subview.updateAppearance()
        }
    }
}

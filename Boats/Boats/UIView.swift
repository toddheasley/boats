import UIKit

extension UIView {
    static let maximumContentWidth: CGFloat = 672.0
    
    @objc var contentRect: CGRect {
        var rect: CGRect = .zero
        rect.origin.y = max(safeAreaInsets.top, 14.0)
        rect.size.height = bounds.size.height - (rect.origin.y + max(safeAreaInsets.bottom, 14.0))
        #if targetEnvironment(macCatalyst)
        rect.origin.x = 14.0
        #else
        rect.origin.x = 9.5
        #endif
        rect.size.width = min(bounds.size.width - (rect.origin.x * 2.0), UIView.maximumContentWidth)
        rect.origin.x = (bounds.size.width - rect.size.width) / 2.0
        return rect
    }
}

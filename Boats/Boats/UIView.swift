import UIKit

extension UIView {
    @objc func setUp() {
        
    }
}

extension UIEdgeInsets {
    static let padding: UIEdgeInsets = UIEdgeInsets(top: 11.0, left: 15.0, bottom: 11.0, right: 15.0)
    
    var size: CGSize {
        return CGSize(width: left + right, height: top + bottom)
    }
}

extension CGSize {
    static let separator: CGSize = CGSize(width: 1.0, height: 1.0)
}

extension CGFloat {
    static let cornerRadius: CGFloat = 7.0
}

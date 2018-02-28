import UIKit

extension UIEdgeInsets {
    static let padding: UIEdgeInsets = UIEdgeInsets(top: 11.0, left: 15.0, bottom: 11.0, right: 15.0)
    
    var width: CGFloat {
        return left + right
    }
    
    var height: CGFloat {
        return top + bottom
    }
}

extension CGFloat {
    static let separatorHeight: CGFloat = 1.0
    static let cornerRadius: CGFloat = 4.0
}

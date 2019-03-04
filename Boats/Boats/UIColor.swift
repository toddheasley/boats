import UIKit

extension UIColor {
    static var background: UIColor {
        return .white
    }
    
    static var color: UIColor {
        return .black
    }
}

extension CGColor {
    static var background: CGColor {
        return UIColor.background.cgColor
    }
    
    static var color: CGColor {
        return UIColor.color.cgColor
    }
}

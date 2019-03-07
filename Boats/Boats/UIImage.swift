import UIKit

extension UIImage {
    #if !os(watchOS)
    static var menu: UIImage? {
        return UIImage(named: "Menu")
    }
    
    #endif
    static var car: UIImage? {
        return UIImage(named: "Car")
    }
}

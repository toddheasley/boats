import WatchKit

extension UIColor {
    static func background(highlighted: Bool = false) -> UIColor {
        return highlighted ? UIColor(white: 0.92, alpha: 0.84) : UIColor(white: 0.15, alpha: 0.81)
    }
    
    static func color(highlighted: Bool = false) -> UIColor {
        return highlighted ? UIColor(white: 0.15, alpha: 1.0) : UIColor(white: 0.92, alpha: 1.0)
    }
}

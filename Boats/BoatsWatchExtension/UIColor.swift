import WatchKit

extension UIColor {
    static func background(highlighted: Bool = false) -> UIColor {
        return highlighted ? UIColor(white: 0.72, alpha: 1.0) : UIColor(white: 0.15, alpha: 1.0)
    }
    
    static func color(highlighted: Bool = false) -> UIColor {
        return highlighted ? UIColor(white: 0.1, alpha: 1.0) : UIColor(white: 0.81, alpha: 1.0)
    }
}

import Cocoa

extension NSEdgeInsets {
    static let padding: NSEdgeInsets = NSEdgeInsets(top: 14.0, left: 19.0, bottom: 12.0, right: 19.0)
    
    var width: CGFloat {
        return left + right
    }
    
    var height: CGFloat {
        return top + bottom
    }
}

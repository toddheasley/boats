import Cocoa

extension NSEdgeInsets {
    static let padding: NSEdgeInsets = NSEdgeInsets(top: 12.0, left: 15.0, bottom: 10.0, right: 15.0)
    
    var width: CGFloat {
        return left + right
    }
    
    var height: CGFloat {
        return top + bottom
    }
}

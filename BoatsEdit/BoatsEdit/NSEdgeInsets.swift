import Cocoa

extension NSEdgeInsets {
    var width: CGFloat {
        return left + right
    }
    
    var height: CGFloat {
        return top + bottom
    }
}

//
//  UIView.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

extension UIView {
    var layoutEdgeInsets: UIEdgeInsets {
        var edgeInsets: UIEdgeInsets = .zero
        edgeInsets.left = round(bounds.size.width * (bounds.size.width < 768.0 ? 0.05 : 0.1))
        edgeInsets.right = edgeInsets.left
        edgeInsets.top = round(edgeInsets.left * (statusBarHeight == 0.0 || edgeInsets.left > 80.0 ? 0.4 : 0.8))
        edgeInsets.bottom = edgeInsets.top
        return edgeInsets
    }
    
    var layoutRect: CGRect {
        return CGRect(x: layoutEdgeInsets.left, y: layoutEdgeInsets.top, width: bounds.size.width - (layoutEdgeInsets.left + layoutEdgeInsets.right), height: bounds.size.height - (layoutEdgeInsets.top + layoutEdgeInsets.bottom))
    }
    
    var statusBarHeight: CGFloat {
        return UIApplication.shared().statusBarFrame.size.height
    }
}

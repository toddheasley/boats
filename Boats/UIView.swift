//
//  UIView.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

extension UIView {
    var layoutInterItemSpacing: CGSize {
        return CGSize(width: 16.0, height: (window?.bounds.size.height ?? 0.0) > 375.0 ? 14.0 : 8.0)
    }
    
    var layoutEdgeInsets: UIEdgeInsets {
        var edgeInsets: UIEdgeInsets = .zero
        edgeInsets.left = layoutInterItemSpacing.width
        edgeInsets.right = edgeInsets.left
        edgeInsets.top = layoutInterItemSpacing.height
        edgeInsets.bottom = edgeInsets.top
        return edgeInsets
    }
    
    var layoutRect: CGRect {
        return CGRect(x: layoutEdgeInsets.left, y: layoutEdgeInsets.top, width: bounds.size.width - (layoutEdgeInsets.left + layoutEdgeInsets.right), height: bounds.size.height - (layoutEdgeInsets.top + layoutEdgeInsets.bottom))
    }
}

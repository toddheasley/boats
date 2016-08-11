//
//  UIView.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

extension UIView {
    var layoutInterItemSpacing: CGSize {
        return CGSize(width: 16.0, height: UIScreen.main.bounds.size.height > 375.0 ? 14.0 : 9.0)
    }
    
    var layoutEdgeInsets: UIEdgeInsets {
        var edgeInsets: UIEdgeInsets = .zero
        edgeInsets.left = layoutInterItemSpacing.width * (UIScreen.main.bounds.size.width < 768.0 ? 1.0 : 4.0)
        edgeInsets.right = edgeInsets.left
        edgeInsets.top = layoutInterItemSpacing.height * (UIScreen.main.bounds.size.height < 768.0 ? 1.0 : 3.0)
        edgeInsets.bottom = edgeInsets.top
        return edgeInsets
    }
    
    var layoutRect: CGRect {
        return CGRect(x: layoutEdgeInsets.left, y: layoutEdgeInsets.top, width: bounds.size.width - (layoutEdgeInsets.left + layoutEdgeInsets.right), height: bounds.size.height - (layoutEdgeInsets.top + layoutEdgeInsets.bottom))
    }
    
    var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
}

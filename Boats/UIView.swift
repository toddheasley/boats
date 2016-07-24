//
//  UIView.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

extension UIView {
    var suggestedFrame: CGRect {
        let inset = suggestedContentInset
        return CGRect(x: inset.left, y: inset.top, width: bounds.size.width - (inset.left + inset.right), height: bounds.size.height - (inset.top + inset.bottom))
    }
    
    var suggestedContentInset: UIEdgeInsets {
        var edgeInsets: UIEdgeInsets = .zero
        guard let size = UIApplication.shared().keyWindow?.bounds.size else {
            return edgeInsets
        }
        edgeInsets.top = 16.0
        edgeInsets.bottom = edgeInsets.top
        if (bounds.size.height == size.height) {
            edgeInsets.top += statusBarHeight
        }
        switch suggestedSizeClass.horizontal {
        case .regular:
            edgeInsets.left = 40.0
        default:
            edgeInsets.left = 20.0
        }
        edgeInsets.right = edgeInsets.left
        return edgeInsets
    }
    
    var suggestedSizeClass: (horizontal: UIUserInterfaceSizeClass, vertical: UIUserInterfaceSizeClass) {
        guard let size = UIApplication.shared().keyWindow?.bounds.size else {
            return (.unspecified, .unspecified)
        }
        return ((size.width < 414.0) ? .compact : .regular, (size.height < 568.0) ? .compact : .regular)
    }
    
    var statusBarHeight: CGFloat {
        return UIApplication.shared().statusBarFrame.size.height
    }
}

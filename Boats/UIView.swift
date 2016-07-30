//
//  UIView.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

extension UIView {
    private var width: CGFloat {
        return 0.0
    }
    
    private var height: CGFloat {
        return 0.0
    }
    
    var layoutRect: CGRect {
        return .zero
    }
    
    var layoutEdgeInsets: UIEdgeInsets {
        return .zero
    }
    
    var statusBarHeight: CGFloat {
        return UIApplication.shared().statusBarFrame.size.height
    }
}

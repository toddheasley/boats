//
//  UIFont.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

extension UIFont {
    static var small: UIFont {
        return .systemFont(ofSize: 9.0, weight: UIFontWeightHeavy)
    }
    
    static var regular: UIFont {
        return .systemFont(ofSize: 13.0, weight: UIFontWeightRegular)
    }
    
    static var medium: UIFont {
        return .systemFont(ofSize: 13.0, weight: UIFontWeightBold)
    }
    
    static var large: UIFont {
        return .systemFont(ofSize: 18.0, weight: UIFontWeightHeavy)
    }
    
    static var time: UIFont {
        return .systemFont(ofSize: 64.0, weight: UIFontWeightHeavy)
    }
}

//
//  UIFont.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

extension UIFont {
    static var xsmall: UIFont {
        return UIFont(name: ".SFUIText_Heavy", size:9.0) ?? .boldSystemFont(ofSize: 9.0)
    }
    
    static var small: UIFont {
        return UIFont(name: ".SFUIText_Medium", size:11.0) ?? .systemFont(ofSize: 11.0)
    }
    
    static var medium: UIFont {
        return UIFont(name: ".SFUIText_Medium", size:13.0) ?? .systemFont(ofSize: 13.0)
    }
    
    static var large: UIFont {
        return .boldSystemFont(ofSize: 17.0)
    }
    
    static var xlarge: UIFont {
        return UIFont(name: ".SFUIDisplay_Heavy", size:24.0) ?? .boldSystemFont(ofSize: 24.0)
    }
}

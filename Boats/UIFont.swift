//
//  UIFont.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

extension UIFont {
    static var small: UIFont {
        return .boldSystemFont(ofSize: 9.0)
    }
    
    static var regular: UIFont {
        return .systemFont(ofSize: 12.0)
    }
    
    static var medium: UIFont {
        return .boldSystemFont(ofSize: 12.0)
    }
    
    static var large: UIFont {
        return .boldSystemFont(ofSize:18.0)
    }
}

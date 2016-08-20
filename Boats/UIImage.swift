//
//  UIImage.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

extension UIImage {
    func tint(color: UIColor) -> UIImage {
        let bounds = CGRect(origin: CGPoint(), size: size)
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        draw(in: bounds)
        context?.setFillColor(color.cgColor)
        context?.setBlendMode(.sourceIn)
        context?.fill(bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

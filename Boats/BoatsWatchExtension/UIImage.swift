import UIKit

extension UIImage {
    static var car: UIImage {
        return UIImage(systemName: "car.fill")!
    }
    
    static func car(scale: CGFloat, on: Bool = true) -> UIImage {
        let car: UIImage = .car
        let rect: CGRect = CGRect(x: 0.0, y: 0.0, width: car.size.width * scale, height: car.size.height * scale)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        if on {
            car.draw(in: rect)
            context.setFillColor(UIColor(white: 0.87, alpha: 1.0).cgColor)
            context.setBlendMode(.sourceAtop)
            context.fill(rect)
            
        }
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

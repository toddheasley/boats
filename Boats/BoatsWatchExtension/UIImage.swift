import UIKit

extension UIImage {
    static var car: UIImage {
        return car(on: true)
    }
    
    static func car(on: Bool, configuration: SymbolConfiguration? = nil) -> UIImage {
        return UIImage(systemName: "car.fill", withConfiguration: configuration)!.template(color: on ? .label() : .clear)
    }
    
    private func template(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        color.set()
        withRenderingMode(.alwaysTemplate).draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}

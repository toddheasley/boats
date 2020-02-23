import UIKit

extension UIImage {
    static func car(color: UIColor? = nil, configuration: SymbolConfiguration? = nil) -> UIImage {
        return UIImage(systemName: "car.fill", withConfiguration: configuration)!.template(color: color)
    }
    
    private func template(color: UIColor?) -> UIImage {
        guard let color: UIColor = color else {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        color.set()
        withRenderingMode(.alwaysTemplate).draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}

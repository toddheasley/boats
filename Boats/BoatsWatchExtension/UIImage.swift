import UIKit
import ClockKit

extension UIImage {
    static var car: UIImage? {
        return UIImage(named: "Car")
    }
    
    static func car(family: CLKComplicationFamily) -> UIImage? {
        switch family {
        case .graphicCircular:
            return UIImage(named: "CarGraphicCircular")
        case .graphicCorner:
            return UIImage(named: "CarGraphicCorner")
        case .graphicRectangular:
            return UIImage(named: "CarGraphicRectangular")
        case .modularLarge:
            return UIImage(named: "CarModular")
        case .utilitarianLarge:
            return UIImage(named: "CarUtilitarian")
        default:
            return nil
        }
    }
}

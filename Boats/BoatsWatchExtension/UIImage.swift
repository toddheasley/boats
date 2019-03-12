import UIKit
import ClockKit

extension UIImage {
    static var car: UIImage? {
        return UIImage(named: "Car")
    }
    
    static func car(family: CLKComplicationFamily, enabled: Bool = false) -> UIImage? {
        let en: String = enabled ? "Enabled" : ""
        switch family {
        case .graphicCircular:
            return UIImage(named: "CarGraphicCircular\(en)")
        case .graphicCorner:
            return UIImage(named: "CarGraphicCorner\(en)")
        case .graphicRectangular:
            return UIImage(named: "CarGraphicRectangular\(en)")
        case .modularLarge:
            return UIImage(named: "CarModular\(en)")
        case .utilitarianLarge:
            return UIImage(named: "CarUtilitarian\(en)")
        default:
            return nil
        }
    }
}

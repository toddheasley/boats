import ClockKit
import BoatsKit
import BoatsBot

extension CLKComplication {
    func template(complications: [Complication] = [.template]) -> CLKComplicationTemplate? {
        switch self.family {
        case .graphicBezel:
            guard let complication: Complication = complications.first, !complication.isExpired,
                let image: UIImage = .car(family: .graphicCircular) else {
                return nil
            }
            let template: CLKComplicationTemplateGraphicBezelCircularText = CLKComplicationTemplateGraphicBezelCircularText()
            template.textProvider = CLKSimpleTextProvider(text: "Depart \(complication.origin.abbreviated) \(complication.day.abbreviated) \(complication.departure.time)", shortText: "Dep. \(complication.origin.abbreviated) \(complication.departure.time)")
            template.circularTemplate = CLKComplicationTemplateGraphicCircularImage()
            (template.circularTemplate as? CLKComplicationTemplateGraphicCircularImage)?.imageProvider = CLKFullColorImageProvider(fullColorImage: image)
            return template
        case .graphicCorner:
            guard let complication: Complication = complications.first, !complication.isExpired else {
                return nil
            }
            let template: CLKComplicationTemplateGraphicCornerTextImage = CLKComplicationTemplateGraphicCornerTextImage()
            if complication.departure.isCarFerry,
                let image: UIImage = .car(family: .utilitarianLarge) {
                template.imageProvider = CLKFullColorImageProvider(fullColorImage: image)
            }
            template.textProvider = CLKSimpleTextProvider(text: "Depart \(complication.origin.abbreviated) \(complication.departure.time)")
            return template
        case .graphicRectangular:
            guard !complications.isEmpty,
                let image: UIImage = .car(family: .graphicRectangular) else {
                return nil
            }
            let template: CLKComplicationTemplateGraphicRectangularStandardBody = CLKComplicationTemplateGraphicRectangularStandardBody()
            template.headerImageProvider = CLKFullColorImageProvider(fullColorImage: image)
            template.headerTextProvider = CLKSimpleTextProvider(text: "Header Text")
            template.body1TextProvider = CLKSimpleTextProvider(text: "Body text")
            
            
            // image | text
            // text
            // text
            
            return template
        case .modularLarge:
            let template: CLKComplicationTemplateModularLargeColumns = CLKComplicationTemplateModularLargeColumns()
            
            // car | time | location
            // car | time | location
            // car | time | location
            
            return nil // template
        case .utilitarianLarge:
            guard let complication: Complication = complications.first, !complication.isExpired else {
                return nil
            }
            let template: CLKComplicationTemplateUtilitarianLargeFlat = CLKComplicationTemplateUtilitarianLargeFlat()
            if complication.departure.isCarFerry,
                let image: UIImage = .car(family: .utilitarianLarge) {
                template.imageProvider = CLKImageProvider(onePieceImage: image)
            }
            template.textProvider = CLKSimpleTextProvider(text: "Depart \(complication.origin.abbreviated) \(complication.departure.time)")
            return template
        default:
            return nil
        }
    }
}

extension Complication {
    fileprivate static var template: Complication {
        return Complication(day: .monday, departure: Departure(time: Time(hour: 16, minute: 20), deviations: [], services: [.car]), destination: Location.peaks, origin: Location.portland)
    }
}

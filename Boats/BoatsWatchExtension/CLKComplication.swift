import ClockKit
import BoatsKit
import BoatsBot

extension CLKComplication {
    func template(complications: [Complication] = .template) -> CLKComplicationTemplate? {
        switch self.family {
        case .graphicBezel:
            guard let complication: Complication = complications.first,
                let image: UIImage = .car(family: .graphicCircular, enabled: complication.departure.isCarFerry) else {
                return nil
            }
            let circularTemplate: CLKComplicationTemplateGraphicCircularImage = CLKComplicationTemplateGraphicCircularImage()
            circularTemplate.imageProvider = CLKFullColorImageProvider(fullColorImage: image)
            let template: CLKComplicationTemplateGraphicBezelCircularText = CLKComplicationTemplateGraphicBezelCircularText()
            template.textProvider = CLKSimpleTextProvider(text: "\(complication.departure.time) dep \(complication.origin.abbreviated)")
            template.circularTemplate = circularTemplate
            return template
        case .graphicCorner:
            guard let complication: Complication = complications.first,
                let image: UIImage = .car(family: .graphicCorner, enabled: complication.departure.isCarFerry) else {
                return nil
            }
            let template: CLKComplicationTemplateGraphicCornerTextImage = CLKComplicationTemplateGraphicCornerTextImage()
            template.textProvider = CLKSimpleTextProvider(text: "\(complication.departure.time) dep \(complication.origin.abbreviated)")
            template.imageProvider = CLKFullColorImageProvider(fullColorImage: image)
            return template
        case .graphicRectangular:
            guard let complication: Complication = complications.first,
                let image: UIImage = .car(family: .graphicRectangular, enabled: complication.departure.isCarFerry) else {
                return nil
            }
            let template: CLKComplicationTemplateGraphicRectangularStandardBody = CLKComplicationTemplateGraphicRectangularStandardBody()
            template.headerTextProvider = CLKSimpleTextProvider(text: "\(complication.departure.time) \(complication.origin.abbreviated)")
            if complication.departure.isCarFerry {
                template.headerImageProvider = CLKFullColorImageProvider(fullColorImage: image)
            }
            if complications.count > 1 {
                template.body1TextProvider = CLKSimpleTextProvider(text: "\(complications[1].departure.time) \(complications[1].origin.abbreviated)")
            } else {
                template.body1TextProvider = CLKSimpleTextProvider(text: "")
            }
            if complications.count > 2 {
                template.body2TextProvider = CLKSimpleTextProvider(text: "\(complications[2].departure.time) \(complications[2].origin.abbreviated)")
            }
            return template
        case .modularLarge:
            guard let complication: Complication = complications.first,
                let image: UIImage = .car(family: .modularLarge, enabled: complication.departure.isCarFerry) else {
                return nil
            }
            let template: CLKComplicationTemplateModularLargeColumns = CLKComplicationTemplateModularLargeColumns()
            template.column2Alignment = .left
            if complication.departure.isCarFerry {
                template.row1ImageProvider = CLKImageProvider(onePieceImage: image)
            }
            template.row1Column1TextProvider = CLKSimpleTextProvider(text: "\(complication.departure.time)")
            template.row1Column2TextProvider = CLKSimpleTextProvider(text: "\(complication.origin.abbreviated)")
            if complications.count > 1,
                let image: UIImage = .car(family: family, enabled: complications[1].departure.isCarFerry) {
                if complications[1].departure.isCarFerry {
                    template.row2ImageProvider = CLKImageProvider(onePieceImage: image)
                }
                template.row2Column1TextProvider = CLKSimpleTextProvider(text: "\(complications[1].departure.time)")
                template.row2Column2TextProvider = CLKSimpleTextProvider(text: "\(complications[1].origin.abbreviated)")
            } else {
                template.row2Column1TextProvider = CLKSimpleTextProvider(text: "")
                template.row2Column2TextProvider = CLKSimpleTextProvider(text: "")
            }
            if complications.count > 2,
                let image: UIImage = .car(family: family, enabled: complications[2].departure.isCarFerry) {
                if complications[2].departure.isCarFerry {
                    template.row3ImageProvider = CLKImageProvider(onePieceImage: image)
                }
                template.row3Column1TextProvider = CLKSimpleTextProvider(text: "\(complications[2].departure.time)")
                template.row3Column2TextProvider = CLKSimpleTextProvider(text: "\(complications[2].origin.abbreviated)")
            } else {
                template.row3Column1TextProvider = CLKSimpleTextProvider(text: "")
                template.row3Column2TextProvider = CLKSimpleTextProvider(text: "")
            }
            return template
        case .utilitarianLarge:
            guard let complication: Complication = complications.first,
                let image: UIImage = .car(family: .utilitarianLarge, enabled: complication.departure.isCarFerry) else {
                    return nil
            }
            let template: CLKComplicationTemplateUtilitarianLargeFlat = CLKComplicationTemplateUtilitarianLargeFlat()
            template.textProvider = CLKSimpleTextProvider(text: "\(complication.departure.time) dep \(complication.origin.abbreviated)")
            if complication.departure.isCarFerry {
                template.imageProvider = CLKImageProvider(onePieceImage: image)
            }
            return template
        default:
            return nil
        }
    }
}

extension Complication {
    fileprivate static var template: [Complication] {
        return [
            Complication(day: .monday, departure: Departure(time: Time(hour: 16, minute: 20), deviations: [], services: [.car]), destination: Location.peaks, origin: Location.portland)
        ]
    }
}

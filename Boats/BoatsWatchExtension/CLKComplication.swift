import ClockKit
import BoatsKit
import BoatsBot

extension CLKComplication {
    func template(complications: [Complication] = Complication.template) -> CLKComplicationTemplate? {
        switch family {
        case .modularLarge:
            return CLKComplicationTemplateModularLargeColumns(complications: complications)
        case .utilitarianLarge:
            return CLKComplicationTemplateUtilitarianLargeFlat(complication: complications.first)
        case .graphicCorner:
            return CLKComplicationTemplateGraphicCornerTextImage(complication: complications.first)
        case .graphicBezel:
            return CLKComplicationTemplateGraphicBezelCircularText(complication: complications.first)
        case .graphicRectangular:
            return CLKComplicationTemplateGraphicRectangularStandardBody(complications: complications)
        default:
            return nil
        }
    }
}

extension CLKComplicationTemplateModularLargeColumns {
    fileprivate convenience init?(complications: [Complication]) {
        guard let complication: Complication = complications.first else {
            return nil
        }
        self.init()
        column2Alignment = .leading
        row1ImageProvider = complication.departure.isCarFerry ? CLKImageProvider(onePieceImage: .car) : nil
        row1Column1TextProvider = CLKSimpleTextProvider(text: "\(complication.departure.time)")
        row1Column2TextProvider = CLKSimpleTextProvider(text: "\(complication.origin.abbreviated)")
        if complications.count > 1 {
            row2ImageProvider = complications[1].departure.isCarFerry ? CLKImageProvider(onePieceImage: .car) : nil
            row2Column1TextProvider = CLKSimpleTextProvider(text: "\(complications[1].departure.time)")
            row2Column2TextProvider = CLKSimpleTextProvider(text: "\(complications[1].origin.abbreviated)")
        } else {
            row2Column1TextProvider = CLKSimpleTextProvider(text: "")
            row2Column2TextProvider = CLKSimpleTextProvider(text: "")
        }
        if complications.count > 2 {
            row3ImageProvider = complications[2].departure.isCarFerry ? CLKImageProvider(onePieceImage: .car) : nil
            row3Column1TextProvider = CLKSimpleTextProvider(text: "\(complications[2].departure.time)")
            row3Column2TextProvider = CLKSimpleTextProvider(text: "\(complications[2].origin.abbreviated)")
        } else {
            row3Column1TextProvider = CLKSimpleTextProvider(text: "")
            row3Column2TextProvider = CLKSimpleTextProvider(text: "")
        }
    }
}

extension CLKComplicationTemplateUtilitarianLargeFlat {
    fileprivate convenience init?(complication: Complication?) {
        guard let complication: Complication = complication else {
            return nil
        }
        self.init()
        textProvider = CLKSimpleTextProvider(text: "\(complication.departure.time) dep \(complication.origin.abbreviated)")
        imageProvider = complication.departure.isCarFerry ? CLKImageProvider(onePieceImage: .car) : nil
    }
}

extension CLKComplicationTemplateGraphicCornerTextImage {
    fileprivate convenience init?(complication: Complication?) {
        guard let complication: Complication = complication else {
            return nil
        }
        self.init()
        textProvider = CLKSimpleTextProvider(text: "\(complication.departure.time) dep \(complication.origin.abbreviated)")
        let image: UIImage = .car(on: complication.departure.isCarFerry, configuration: UIImage.SymbolConfiguration(scale: .small))
        imageProvider = CLKFullColorImageProvider(fullColorImage: image, tintedImageProvider: CLKImageProvider(onePieceImage: image.withRenderingMode(.alwaysTemplate)))
    }
}

extension CLKComplicationTemplateGraphicBezelCircularText {
    fileprivate convenience init?(complication: Complication?) {
        guard let complication: Complication = complication else {
            return nil
        }
        self.init()
        textProvider = CLKSimpleTextProvider(text: "\(complication.departure.time) dep \(complication.origin.abbreviated)")
        let template: CLKComplicationTemplateGraphicCircularImage = CLKComplicationTemplateGraphicCircularImage()
        let image: UIImage = .car(on: complication.departure.isCarFerry, configuration: UIImage.SymbolConfiguration(scale: .large))
        template.imageProvider = CLKFullColorImageProvider(fullColorImage: image, tintedImageProvider: CLKImageProvider(onePieceImage: image.withRenderingMode(.alwaysTemplate)))
        circularTemplate = template
    }
}

extension CLKComplicationTemplateGraphicRectangularStandardBody {
    fileprivate convenience init?(complications: [Complication]) {
        guard let complication: Complication = complications.first else {
            return nil
        }
        self.init()
        headerTextProvider = CLKSimpleTextProvider(text: "\(complication.departure.time) \(complication.origin.abbreviated)")
        if complication.departure.isCarFerry {
            let image: UIImage = .car(on: true, configuration: UIImage.SymbolConfiguration(pointSize: 11.0, weight: .semibold))
            headerImageProvider = CLKFullColorImageProvider(fullColorImage: image, tintedImageProvider: CLKImageProvider(onePieceImage: image.withRenderingMode(.alwaysTemplate)))
        }
        body1TextProvider = CLKSimpleTextProvider(text: complications.count > 1 ? "\(complications[1].departure.time) \(complications[1].origin.abbreviated)" : "")
        body2TextProvider = CLKSimpleTextProvider(text: complications.count > 2 ? "\(complications[2].departure.time) \(complications[2].origin.abbreviated)" : "")
    }
}

extension Complication {
    fileprivate static var template: [Complication] {
        return [
            Complication(day: .monday, departure: Departure(time: Time(hour: 16, minute: 30), deviations: [], services: [.car]), destination: Location.peaks, origin: Location.portland),
            Complication(day: .monday, departure: Departure(time: Time(hour: 17, minute: 0), deviations: [], services: [.car]), destination: Location.portland, origin: Location.peaks),
            Complication(day: .monday, departure: Departure(time: Time(hour: 17, minute: 35), deviations: [], services: [.car]), destination: Location.peaks, origin: Location.portland)
        ]
    }
}

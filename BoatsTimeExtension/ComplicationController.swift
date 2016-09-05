//
//  ComplicationController.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: CLKComplicationDataSource
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([])
    }
    
    func getPlaceholderTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        switch complication.family {
        case .modularSmall:
            let template = CLKComplicationTemplateModularSmallStackImage()
            template.line1ImageProvider = CLKImageProvider(onePieceImage: UIImage(named: "ModularStack")!)
            template.line2TextProvider = CLKSimpleTextProvider(text: "--:--")
            handler(template)
        case .modularLarge:
            let template = CLKComplicationTemplateModularLargeStandardBody()
            template.headerImageProvider = CLKImageProvider(onePieceImage: UIImage(named: "ModularLarge")!)
            template.headerTextProvider = CLKSimpleTextProvider(text: "--:--")
            template.body1TextProvider = CLKSimpleTextProvider(text: "Destination")
            template.body2TextProvider = CLKSimpleTextProvider(text: "")
            handler(template)
        case .utilitarianSmallFlat:
            let template = CLKComplicationTemplateUtilitarianSmallFlat()
            template.imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "UtilitarianFlat")!)
            template.textProvider = CLKSimpleTextProvider(text: "--:--")
            handler(template)
        case .utilitarianLarge:
            let template = CLKComplicationTemplateUtilitarianLargeFlat()
            template.imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "UtilitarianFlat")!)
            template.textProvider = CLKSimpleTextProvider(text: "--:-- Destination")
            handler(template)
        default:
            handler(nil)
        }
    }
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        handler(nil)
    }
}

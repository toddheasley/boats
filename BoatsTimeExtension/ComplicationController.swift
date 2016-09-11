//
//  ComplicationController.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation
import ClockKit
import BoatsData

typealias ComplicationContext = (time: String, destination: String, cars: Bool)

class ComplicationController: NSObject, CLKComplicationDataSource {
    func template(complication: CLKComplication, context: ComplicationContext = (time: Time.string(), destination: "", cars: true)) -> CLKComplicationTemplate? {
        switch complication.family {
        case .modularSmall:
            let template = CLKComplicationTemplateModularSmallStackImage()
            template.line1ImageProvider = CLKImageProvider(onePieceImage: UIImage(named: "ModularStack")!)
            template.line2TextProvider = CLKSimpleTextProvider(text: context.time)
            return template
        case .modularLarge:
            let template = CLKComplicationTemplateModularLargeStandardBody()
            template.headerImageProvider = context.cars ? CLKImageProvider(onePieceImage: UIImage(named: "ModularLarge")!) : nil
            template.headerTextProvider = CLKSimpleTextProvider(text: context.time)
            template.body1TextProvider = CLKSimpleTextProvider(text: context.destination)
            template.body2TextProvider = CLKSimpleTextProvider(text: "")
            return template
        case .utilitarianSmall:
            let template = CLKComplicationTemplateUtilitarianSmallFlat()
            template.imageProvider = context.cars ? CLKImageProvider(onePieceImage: UIImage(named: "UtilitarianFlat")!) : nil
            template.textProvider = CLKSimpleTextProvider(text: context.time)
            return template
        case .utilitarianLarge:
            let destination = context.destination.components(separatedBy: " ")[0]
            let template = CLKComplicationTemplateUtilitarianLargeFlat()
            template.imageProvider = context.cars ? CLKImageProvider(onePieceImage: UIImage(named: "UtilitarianFlat")!) : nil
            template.textProvider = CLKSimpleTextProvider(text: "\(context.time) \(destination)")
            return template
        default:
            return nil
        }
    }
    
    // MARK: CLKComplicationDataSource
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        handler(template(complication: complication))
    }
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward])
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Foundation.Date?) -> Void) {
        guard let _ = template(complication: complication), let context = UserDefaults.standard.context, let departure = context.route.schedule()?.departures(direction: context.direction).last else {
            handler(nil)
            return
        }
        let date = Calendar.current.startOfDay(for: Foundation.Date())
        var components = DateComponents()
        components.hour = departure.time.hour
        components.minute = departure.time.minute
        handler(Calendar.current.date(byAdding: components, to: date))
    }
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        guard let template = template(complication: complication) else {
            handler(nil)
            return
        }
        if let context = UserDefaults.standard.context {
            var complicationContext: ComplicationContext = (Time.string(), "", false)
            complicationContext.destination = context.direction == .destination ? context.route.destination.name : context.route.origin.name
            if let departure = context.route.schedule()?.departure(direction: context.direction) {
                complicationContext.time = departure.time.string
                complicationContext.cars = departure.cars
            }
            handler(CLKComplicationTimelineEntry(date: Foundation.Date(), complicationTemplate: self.template(complication: complication, context: complicationContext)!))
            return
        }
        handler(CLKComplicationTimelineEntry(date: Foundation.Date(), complicationTemplate: template))
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Foundation.Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        guard let _ = template(complication: complication), let context = UserDefaults.standard.context, let departures = context.route.schedule()?.departures(time: Time(date: date), direction: context.direction) else {
            handler(nil)
            return
        }
        let date = Calendar.current.startOfDay(for: date)
        let destination = context.direction == .destination ? context.route.destination.name : context.route.origin.name
        var components = DateComponents()
        var timelineEntries: [CLKComplicationTimelineEntry] = []
        for departure in departures {
            if let template = template(complication: complication, context: (departure.time.string, destination, departure.cars)), let date = Calendar.current.date(byAdding: components, to: date) {
                timelineEntries.append(CLKComplicationTimelineEntry(date: date, complicationTemplate: template))
                components.hour = departure.time.hour
                components.minute = departure.time.minute
            }
        }
        timelineEntries.append(CLKComplicationTimelineEntry(date: Calendar.current.date(byAdding: components, to: date)!, complicationTemplate: template(complication: complication, context: (Time.string(), destination, false))!))
        handler(timelineEntries)
    }
    
    func getNextRequestedUpdateDate(handler: @escaping (Foundation.Date?) -> Void) {
        let date = Calendar.current.startOfDay(for: Foundation.Date())
        var components = DateComponents()
        components.day = 1
        handler(Calendar.current.date(byAdding: components, to: date))
    }
    
    func requestedUpdateDidBegin() {
        for complication in CLKComplicationServer.sharedInstance().activeComplications! {
            CLKComplicationServer.sharedInstance().reloadTimeline(for: complication)
        }
    }
    
    func requestedUpdateBudgetExhausted() {
        
    }
}

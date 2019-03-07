import ClockKit
import BoatsKit
import BoatsBot

class ComplicationController: NSObject, CLKComplicationDataSource {
    static var index: Index = Index() {
        didSet {
            for complication in CLKComplicationServer.sharedInstance().activeComplications ?? [] {
                CLKComplicationServer.sharedInstance().reloadTimeline(for: complication)
            }
        }
    }
    
    // MARK: CLKComplicationDataSource
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        handler(nil)
        //handler(complication.template())
    }
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        handler(nil)
        /*
        guard let template: CLKComplicationTemplate = complication.template(device: ComplicationController.device) else {
            handler(nil)
            return
        }
        handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)) */
    }
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([])
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
}

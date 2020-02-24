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
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        let date: Date = Date()
        if let template: CLKComplicationTemplate = complication.template(complications: ComplicationController.index.complications(from: date, limit: 3, filter: true)) {
            handler(CLKComplicationTimelineEntry(date: date, complicationTemplate: template))
        } else {
            handler(nil)
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        let complications: [Complication] = ComplicationController.index.complications(from: date, filter: true)
        var entries: [CLKComplicationTimelineEntry] = []
        for index in 0..<(min(complications.count - 2, limit)) {
            guard let date: Date = (index > 0 ? complications[index - 1].date : Date(timeInterval: 61.0, since: date)),
                let template: CLKComplicationTemplate = complication.template(complications: Array(complications[index...(index + 2)])) else {
                continue
            }
            entries.append(CLKComplicationTimelineEntry(date: date, complicationTemplate: template))
        }
        handler(entries)
    }
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        handler(complication.template())
    }
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([])
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
}

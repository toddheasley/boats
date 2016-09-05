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
        handler(nil)
    }
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        handler(nil)
    }
}

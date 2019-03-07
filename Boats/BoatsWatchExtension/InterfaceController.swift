import WatchKit
import BoatsKit
import BoatsBot

class InterfaceController: WKInterfaceController {
    var index: Index = Index() {
        didSet {
            update()
        }
    }
    
    var route: Route {
        return index.current ?? index.routes.first!
    }
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    private let maxDepartures: Int = 3
    
    private func update() {
        setTitle(route.name)
        if let timetables: [Timetable] = route.schedule()?.current(), !timetables.isEmpty {
            var departures: [(day: Day, departure: Departure, location: Location)] = []
            for timetable in timetables {
                for trip in timetable.trips {
                    if departures.count < maxDepartures, let departure: Departure = trip.origin {
                        departures.append((timetable.days.first!, departure, index.location))
                    }
                    if departures.count < maxDepartures, let departure: Departure = trip.destination {
                        departures.append((timetable.days.first!, departure, route.location))
                    }
                }
            }
            table.setNumberOfRows(departures.count, withRowType: "Timetable")
            for (index, departure) in departures.enumerated() {
                guard let controller: TimetableController = table.rowController(at: index) as? TimetableController else {
                    continue
                }
                controller.setDay(departure.day)
                controller.setLocation(departure.location)
                controller.setDeparture(departure.departure)
                controller.setHighlighted(index == 0)
            }
        } else {
            table.setNumberOfRows(1, withRowType: "Empty")
        }
    }
    
    // MARK: WKInterfaceController
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        (WKExtension.shared().delegate as? ExtensionDelegate)?.refresh()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        update()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
}

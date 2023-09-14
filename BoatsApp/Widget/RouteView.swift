import WidgetKit
import SwiftUI
import Boats

struct RouteView: View {
    let route: Route
    let date: Date
    
    init(_ route: Route, for date: Date = Date()) {
        self.route = route
        self.date = date
        localDepartures = route.localDepartures(from: date)
        dayTrips = route.dayTrips(from: date)
    }
    
    @Environment(\.widgetFamily) private var widgetFamily: WidgetFamily
    private let localDepartures: [Route.LocalDeparture]
    private let dayTrips: [Route.DayTrip]
    
    // MARK: View
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            TimetableView(localDepartures, limit: 2, route: route)
        case .systemMedium, .systemExtraLarge:
            TimetableView(dayTrips, limit: 2, route: route)
        case .systemLarge:
            TimetableView(dayTrips, limit: 6, route: route)
        case .accessoryCorner:
            AccessoryCornerView(localDepartures.first, route: route)
        case .accessoryCircular:
            AccessoryCircularView(localDepartures.first, route: route)
        case .accessoryRectangular:
            AccessoryRectangularView(dayTrips, route: route)
        default:
            AccessoryLabel(localDepartures.first, route: route)
        }
    }
}

/*
#Preview("Route View") {
    RouteView(.chebeague)
} */

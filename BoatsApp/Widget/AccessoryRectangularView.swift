import WidgetKit
import SwiftUI
import Boats

struct AccessoryRectangularView: View {
    private(set) var origin: (top: Departure?, bottom: Departure?) = (nil, nil)
    private(set) var destination: (top: Departure?, bottom: Departure?) = (nil, nil)
    let route: Route
    
    init(_ dayTrips: [Route.DayTrip] = [], route: Route) {
        origin.top = dayTrips.first?.trip.origin
        destination.top = dayTrips.first?.trip.destination
        if dayTrips.count > 1 {
            origin.bottom = dayTrips[1].trip.origin
            destination.bottom = dayTrips[1].trip.destination
        }
        self.route = route
    }
    
    // MARK: View
    var body: some View {
        HStack {
            VStack {
                Header("→ \(route.codename)")
                Cell(alignment: .trailing) {
                    DepartureView(origin.top)
                }
                Cell(alignment: .trailing) {
                    DepartureView(origin.bottom)
                }
            }
            Divider()
            VStack {
                Header("← \(route.codename)")
                Cell(alignment: .trailing) {
                    DepartureView(destination.top)
                }
                Cell(alignment: .trailing) {
                    DepartureView(destination.bottom)
                }
             }
         }
    }
}

/*
#Preview("Accessory Rectangular View") {
    AccessoryRectangularView(route: .peaks)
} */

private struct Header: View {
    let content: String
    
    init(_ content: String = "") {
        self.content = content
    }
    
    // MARK: View
    var body: some View {
        Cell {
            Text(content)
                .font(.caption)
                .opacity(0.8)
        }
        .padding(.horizontal)
    }
}

/*
#Preview("Header") {
    Header("→ PEAKS")
} */

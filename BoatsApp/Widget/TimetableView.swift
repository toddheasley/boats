import WidgetKit
import SwiftUI
import BoatsWeb
import Boats

struct TimetableView: View {
    let dayTrips: [Route.DayTrip]
    let localDepartures: [Route.LocalDeparture]
    let route: Route
    
    init(_ dayTrips: [Route.DayTrip] = [], limit: Int = -1, route: Route) {
        self.route = route
        if limit > 0 {
            self.dayTrips = Array(dayTrips[0..<min(limit, dayTrips.count)])
        } else {
            self.dayTrips = limit < 0 ? dayTrips : []
        }
        localDepartures = []
    }
    
    init(_ localDepartures: [Route.LocalDeparture], limit: Int = -1, route: Route) {
        self.route = route
        if limit > 0 {
            self.localDepartures = Array(localDepartures[0..<min(limit, localDepartures.count)])
        } else {
            self.localDepartures = limit < 0 ? localDepartures : []
        }
        dayTrips = []
    }
    
    // MARK: View
    var body: some View {
        VStack(spacing: .spacing) {
            Header(route)
            if !dayTrips.isEmpty {
                HStack(spacing: .spacing) {
                    TripLabel(.portland)
                    TripLabel(route.location)
                }
                ForEach(dayTrips.indices, id: \.self) { index in
                    TripView(dayTrips[index].trip, index: index)
                }
            } else if !localDepartures.isEmpty {
                ForEach(localDepartures.indices, id: \.self) { index in
                    TripLabel(localDepartures[index].location)
                    Cell {
                        DepartureView(localDepartures[index].departure)
                    }
                    .backgroundColor(index)
                }
            } else {
                VStack {
                    Spacer()
                    SeasonLabel(alignment: .center)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .backgroundColor(.haze)
            }
        }
        .clipped(corners: 10.0)
    }
}

/*
#Preview("Timetable View") {
    TimetableView(route: .peaks)
} */

// MARK: Header
private struct Header: View {
    let route: Route
    
    init(_ route: Route) {
        self.route = route
    }
    
    // MARK: View
    var body: some View {
        Cell {
            RouteLabel(route)
        }
        .padding(.horizontal, 6.5)
        .padding(.vertical, 3.0)
        .backgroundColor(.navy, dark: .haze)
    }
}

/*
#Preview("Header") {
    Header(.chebeague)
} */

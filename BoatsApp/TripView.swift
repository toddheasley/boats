import SwiftUI
import BoatsWeb
import Boats

struct TripView: View {
    let trip: Timetable.Trip
    let index: Int
    
    init(_ trip: Timetable.Trip, index: Int? = nil) {
        self.trip = trip
        self.index = index ?? 0
    }
    
    // MARK: View
    var body: some View {
        HStack(spacing: .spacing) {
            Cell {
                DepartureView(trip.origin)
            }
            .backgroundColor(index)
            Cell {
                DepartureView(trip.destination)
            }
            .backgroundColor(index)
        }
        .clipped()
    }
}

#Preview("Trip View") {
    VStack(spacing: .spacing) {
        TripView(Timetable.Trip(origin: Departure(Time(hour: 22, minute: 9), services: [
                .car
            ]), destination: Departure(Time(hour: 22, minute: 9), services: [
                .car
            ])))
        TripView(Timetable.Trip(destination: Departure(Time(hour: 22, minute: 9), deviations: [
                .only(.saturday)
            ])))
    }
}

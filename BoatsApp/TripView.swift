import SwiftUI
import BoatsWeb
import Boats

struct TripView: View {
    let trip: Timetable.Trip
    let origin: Location
    let destination: Location
    let index: Int
    
    init(_ trip: Timetable.Trip, origin: Location = .portland, destination: Location, index: Int? = nil) {
        self.trip = trip
        self.origin = origin
        self.destination = destination
        self.index = index ?? 0
    }
    
    // MARK: View
    var body: some View {
        HStack(spacing: .spacing) {
            DepartureCell(trip.origin, location: origin, index: index)
            DepartureCell(trip.destination, location: destination, index: index)
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
            ])), destination: .peaks)
        TripView(Timetable.Trip(destination: Departure(Time(hour: 22, minute: 9), deviations: [
                .only(.saturday)
        ])), destination: .chebeague)
    }
}

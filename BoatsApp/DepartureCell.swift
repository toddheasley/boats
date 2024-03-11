import SwiftUI
import BoatsWeb
import Boats

struct DepartureCell: View {
    let departure: Departure?
    let location: Location
    let index: Int
    
    init(_ departure: Departure?, location: Location, index: Int? = nil) {
        self.departure = departure
        self.location = location
        self.index = index ?? 0
    }
    
    // MARK: View
    var body: some View {
        Cell {
            DepartureView(departure)
                .accessibilityHidden(true)
        }
        .backgroundColor(index)
        .accessibilityElement()
        .accessibilityLabel(departure != nil ? "\(location.direction) \(departure!.accessibilityDescription)" : "")
        .accessibilityHidden(departure == nil)
    }
}

#Preview("Departure Cell") {
    VStack(spacing: .spacing) {
        DepartureCell(Departure(Time(), deviations: [
        ], services: [
            .car
        ]), location: .peaks, index: 1)
        DepartureCell(Departure(Time(hour: 22, minute: 9), deviations: [
                .only(.saturday)
        ]), location: .chebeague)
        DepartureCell(nil, location: .peaks, index: 1)
    }
}

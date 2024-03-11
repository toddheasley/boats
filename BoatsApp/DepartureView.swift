import SwiftUI
import BoatsWeb
import Boats

struct DepartureView: View {
    let departure: Departure?
    
    init(_ departure: Departure? = nil) {
        self.departure = departure
    }
    
    private var deviations: String? {
        guard let components = departure?.components(), !components[2].isEmpty else {
            return nil
        }
        return components[2]
    }
    
    // MARK: View
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            HStack(alignment: .firstTextBaseline, spacing: .spacing) {
                TimeView(departure?.time)
                    .time()
                Text(Service.car.emoji)
                    .time()
                    .opacity((departure?.isCarFerry ?? false) ? 1.0 : 0.0)
            }
            .padding(.horizontal, .spacing)
            .padding(.vertical, 1.0)
            .accessibilityHidden(true)
            DeviationsView(deviations)
                .padding(.horizontal, 10.0)
                .padding(.vertical, 3.5)
                .accessibilityHidden(true)
        }
        .accessibilityElement()
        .accessibilityLabel(departure?.accessibilityDescription ?? "")
        .accessibilityHidden(departure == nil)
    }
}

#Preview("Departure View") {
    VStack(spacing: .spacing) {
        DepartureView(Departure(Time(), deviations: [
            ], services: [
                .car
            ]))
            .backgroundColor(.haze)
        DepartureView(Departure(Time(hour: 22, minute: 9), deviations: [
                .only(.saturday)
            ]))
            .backgroundColor(.haze)
        DepartureView()
            .backgroundColor(.haze)
    }
}

// MARK: DeviationsView
private struct DeviationsView: View {
    let deviations: String?
    
    init(_ deviations: String? = nil) {
        self.deviations = deviations
    }
    
    private var insets: EdgeInsets {
#if os(watchOS)
        return EdgeInsets(top: -1.0, leading: 1.0, bottom: -1.0, trailing: 1.0)
#else
        return EdgeInsets(top: 1.0, leading: 1.5, bottom: -1.0, trailing: 1.5)
#endif
    }
    
    // MARK: View
    var body: some View {
        if let deviations, !deviations.isEmpty {
            Text(deviations)
                .tiny()
                .padding(insets)
                .foregroundColor(.black)
                .backgroundColor(.aqua)
                .clipped(corners: 2.5)
                .shadow(0.25)
        }
    }
}

#Preview("Deviations View") {
    DeviationsView("Sat only")
}

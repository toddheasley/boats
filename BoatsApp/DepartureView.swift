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
            HStack(alignment: .firstTextBaseline) {
                TimeView(departure?.time)
                    .font(.system(.largeTitle, weight: .bold))
                Text(Service.car.emoji)
                    .font(.system(.headline))
                    .opacity((departure?.isCarFerry ?? false) ? 1.0 : 0.0)
            }
            DeviationsView(deviations)
                .padding(2.0)
        }
        .accessibilityLabel(departure?.description ?? "")
        .accessibility(hidden: departure == nil)
    }
}

struct DepartureView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        VStack {
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
}

// MARK: DeviationsView
private struct DeviationsView: View {
    let deviations: String?
    
    init(_ deviations: String? = nil) {
        self.deviations = deviations
    }
    
    private let insets: EdgeInsets = EdgeInsets(top: 2.0, leading: 2.5, bottom: 1.0, trailing: 2.5)
    
    // MARK: View
    var body: some View {
        if let deviations, !deviations.isEmpty {
            Text(deviations)
                .textCase(.uppercase)
                .font(.system(size: 9.5))
                .padding(insets)
                .foregroundColor(.black)
                .backgroundColor(.aqua)
                .cornerRadius(2.5)
                .shadow()
                .accessibilityLabel(deviations)

        }
    }
}

struct DeviationsView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        DeviationsView("Sat only")
    }
}


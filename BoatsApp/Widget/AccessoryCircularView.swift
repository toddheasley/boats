import WidgetKit
import SwiftUI
import Boats

struct AccessoryCircularView: View {
    let localDeparture: Route.LocalDeparture?
    let route: Route
    
    init(_ localDeparture: Route.LocalDeparture? = nil, route: Route) {
        self.localDeparture = localDeparture
        self.route = route
    }
    
    // MARK: View
    var body: some View {
        if let localDeparture {
            VStack {
                Text(localDeparture.departure.time.description)
                Text(route.codename)
                    .font(.caption)
                Text("\(route.location == localDeparture.location ? "←" : "→")\(localDeparture.departure.isCarFerry ? " \(Service.car.emoji)" : "")")
            }
        } else {
            Image(systemName: "ferry.fill")
                .font(.largeTitle)
        }
    }
}

/*
#Preview("Accessory Circular View") {
    AccessoryCircularView(route: .peaks)
} */

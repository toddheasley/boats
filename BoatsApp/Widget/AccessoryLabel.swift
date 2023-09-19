import WidgetKit
import SwiftUI
import Boats

struct AccessoryLabel: View {
    let localDeparture: Route.LocalDeparture?
    let route: Route
    
    init(_ localDeparture: Route.LocalDeparture? = nil, route: Route) {
        self.localDeparture = localDeparture
        self.route = route
    }
    
    private var direction: String {
        return route.location == localDeparture?.location ? "←" : "→"
    }
    
    // MARK: View
    var body: some View {
        if let localDeparture {
            Text("\(localDeparture.departure.time.description) \(direction) \(route.codename)")
        } else {
            Text("BOATS")
        }
    }
}

/*
#Preview("Accessory Label") {
    AccessoryLabel(route: .peaks)
} */

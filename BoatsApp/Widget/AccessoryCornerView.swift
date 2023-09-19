import WidgetKit
import SwiftUI
import Boats

struct AccessoryCornerView: View {
    let localDeparture: Route.LocalDeparture?
    let route: Route
    
    init(_ localDeparture: Route.LocalDeparture? = nil, route: Route) {
        self.localDeparture = localDeparture
        self.route = route
    }
    
    // MARK: View
    var body: some View {
        if let localDeparture {
            ZStack {
                AccessoryWidgetBackground()
                if localDeparture.departure.isCarFerry {
                    Text(Service.car.emoji)
                        .font(.largeTitle)
                } else {
                    Image(systemName: "ferry.fill")
                }
            }
#if os(watchOS)
            .widgetLabel {
                AccessoryLabel(localDeparture, route: route)
            }
#endif
        } else {
            Image(systemName: "ferry.fill")
                .font(.largeTitle)
        }
    }
}

/*
#Preview("Accessory Corner View") {
    AccessoryCornerView(route: .peaks)
} */

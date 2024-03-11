#if canImport(WidgetKit)
import WidgetKit
#endif
import SwiftUI
import BoatsWeb
import Boats

struct RouteLabel: View {
    let route: Route?
    
    init(_ route: Route? = nil) {
        self.route = route
    }
    
#if canImport(WidgetKit)
    @Environment(\.widgetFamily) private var widgetFamily: WidgetFamily
    
#endif
    // MARK: View
    var body: some View {
        HStack(spacing: 0.0) {
#if canImport(WidgetKit)
            switch widgetFamily {
            case .systemSmall:
                Text(route?.location.nickname ?? "")
                    .head()
            default:
                Text(route?.location.name ?? "")
                    .head()
            }
#else
            Text(route?.location.name ?? "")
                .head()
#endif
            Spacer()
        }
        .accessibilityAddTraits(.isHeader)
        .accessibilityLabel(route?.description ?? "")
        .accessibilityHidden(route == nil)
    }
}

#Preview("Route Label") {
    RouteLabel(.peaks)
        .backgroundColor(.haze)
}

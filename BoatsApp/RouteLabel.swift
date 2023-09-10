import SwiftUI
import BoatsWeb
import Boats

struct RouteLabel: View {
    let route: Route?
    
    init(_ route: Route? = nil) {
        self.route = route
    }
    
    private var description: String {
        return route?.description ?? ""
    }
    
    // MARK: View
    var body: some View {
        HStack(spacing: 0.0) {
            Text(description)
                .head()
                .lineLimit(1)
            Spacer()
        }
    }
}

#Preview("Route Label") {
    RouteLabel(.peaks)
        .backgroundColor(.haze)
}

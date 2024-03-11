import SwiftUI
import BoatsWeb
import Boats

struct TripLabel: View {
    let location: Location?
    
    init(_ location: Location? = nil) {
        self.location = location
    }
    
    // MARK: View
    var body: some View {
        Cell {
            Text(location?.direction ?? "")
                .tiny()
                .foregroundColor(.black)
                .padding(2.0)
        }
        .backgroundColor(.aqua)
    }
}

#Preview("Trip Label") {
    VStack(spacing: .spacing) {
        TripLabel(.chebeague)
            .backgroundColor(.haze)
        TripLabel()
            .backgroundColor(.haze)
    }
}

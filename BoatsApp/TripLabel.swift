import SwiftUI
import BoatsWeb
import Boats

struct TripLabel: View {
    let location: Location?
    
    init(_ location: Location? = nil) {
        self.location = location
    }
    
    private var description: String {
        guard let location else {
            return ""
        }
        return "Depart \(location.nickname)"
    }
    
    // MARK: View
    var body: some View {
        Cell {
            Text(description)
                .tiny()
                .foregroundColor(.black)
                .padding(2.0)
        }
        .backgroundColor(.aqua)
        .accessibilityLabel(description)
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

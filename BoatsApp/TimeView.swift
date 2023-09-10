import SwiftUI
import BoatsWeb
import Boats

struct TimeView: View {
    let time: Time?
    
    init(_ time: Time? = Time()) {
        self.time = time
        components = (time ?? Time()).components(empty: " ")
    }
    
    private let components: [String]
    
    // MARK: View
    var body: some View {
        HStack(spacing: 1.0) {
            Text(components[0])
                .monospaced(components[0] == " ")
            Text(components[1])
            Text(components[2])
            Text(components[3])
            Text(components[4])
            Text(components[5])
        }
        .opacity(time == nil ? 0.0 : 1.0)
        .accessibilityLabel(time?.description ?? "")
        .accessibility(hidden: time == nil)
        .monospacedDigit()
    }
}

#Preview("Time View") {
    VStack(spacing: .spacing) {
        TimeView()
            .backgroundColor(.haze)
        TimeView(Time(hour: 22, minute: 9))
            .backgroundColor(.haze)
        TimeView(nil)
            .backgroundColor(.haze)
    }
}

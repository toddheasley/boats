import SwiftUI
import Boats

struct TimeView: View {
    let time: Time
    
    init(_ time: Time = Time()) {
        self.time = time
        components = time.components(empty: " ")
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
        .accessibilityLabel(time.description)
        .monospacedDigit()
    }
}

struct TimeView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        TimeView()
    }
}

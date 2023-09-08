import SwiftUI
import BoatsWeb
import Boats

struct SeasonView: View {
    let season: Season?
    
    init(_ season: Season? = nil) {
        self.season = season
        self.description = season?.description ?? "Schedule unavailable"
    }
    
    private let description: String
    
    // MARK: View
    var body: some View {
        HStack {
            Text(description)
            Spacer()
        }
        .accessibilityLabel(description)
    }
}

#Preview("Season View") {
    VStack {
        SeasonView(try! JSONDecoder().decode(Season.self, from: _data))
            .backgroundColor(.haze)
        SeasonView()
            .backgroundColor(.haze)
    }
}

private let _data: Data = """
{
    "name": "spring",
    "dateInterval": {
        "start":1681531200,
        "duration":5443199
    }
}
""".data(using: .utf8)!

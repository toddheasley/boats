import SwiftUI
import BoatsWeb
import Boats

struct SeasonLabel: View {
    let season: Season?
    
    init(_ season: Season? = nil) {
        self.season = season
    }
    
    private var description: String {
        return season?.description ?? "Schedule unavailable"
    }
    
    // MARK: View
    var body: some View {
        HStack(spacing: 0.0) {
            Text(description)
                .font(.season)
                .lineLimit(1)
                .opacity(0.9)
            Spacer()
        }
    }
}

#Preview("Season Label") {
    VStack(spacing: .spacing) {
        SeasonLabel(try! JSONDecoder().decode(Season.self, from: _data))
            .backgroundColor(.haze)
        SeasonLabel()
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

import SwiftUI
import BoatsWeb
import Boats

struct SeasonLabel: View {
    let alignment: HorizontalAlignment
    let season: Season?
    
    init(_ season: Season? = nil, alignment: HorizontalAlignment = .leading) {
        self.alignment = alignment
        self.season = season
    }
    
    private var description: String {
        return season?.description ?? "Schedule unavailable"
    }
    
    // MARK: View
    var body: some View {
        Cell(alignment: alignment) {
            Text(description)
                .font(.season)
                .lineLimit(1)
                .opacity(0.9)
        }
        .accessibilityLabel(description)
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

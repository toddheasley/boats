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
    
    private let description: String = "Schedule unavailable"
    
    // MARK: View
    var body: some View {
        Cell(alignment: alignment) {
            Text(season?.description ?? description)
                .font(.season)
                .lineLimit(1)
                .opacity(0.9)
        }
        .accessibilityLabel(season?.accessibilityDescription ?? description)
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

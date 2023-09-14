import WidgetKit
import AppIntents
import SwiftUI
import BoatsWeb
import Boats

@main
struct Widget: SwiftUI.Widget {
    let kind: String = "Widget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: Provider.Intent.self, provider: Provider()) { entry in
            RouteView(entry.route, for: entry.date)
                .containerBackground(for: .widget) {
                    Spacer()
                        .backgroundColor()
                }
        }
    }
}

private extension WidgetFamily {
    static var previewDefault: Self {
#if os(watchOS)
        return .accessoryRectangular
#else
        return .systemMedium
#endif
    }
}

#Preview("Widget", as: .previewDefault) {
    Widget()
} timeline: {
    Provider.Entry()
}

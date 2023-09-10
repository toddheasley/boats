import WidgetKit
import AppIntents
import SwiftUI

@main
struct Widget: SwiftUI.Widget {
    let kind: String = "Widget"
    
    @Environment(\.widgetFamily) private var widgetFamily: WidgetFamily
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: Provider.Intent.self, provider: Provider()) { entry in
            EntryView(entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

/*
#Preview(as: .systemMedium) {
    Widget()
} timeline: {
    Provider.Entry(.now, configuration: Provider.Intent())
} */

// MARK: EntryView
private struct EntryView: View {
    var entry: Provider.Entry
    
    init(_ entry: Provider.Entry) {
        self.entry = entry
    }
    
    // MARK: View
    var body: some View {
        Text(entry.date, style: .time)
        Text(entry.route.description)
    }
}



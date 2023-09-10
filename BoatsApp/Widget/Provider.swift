import WidgetKit
import AppIntents
import Boats

struct Provider: AppIntentTimelineProvider {
    struct Intent: WidgetConfigurationIntent, CustomStringConvertible {
        @Parameter(title: "Route", default: .peaks) var route: RouteEnum
        
        init(_ route: Route) {
            self.route = RouteEnum(route)
        }
        
        init() {
            
        }
        
        // MARK: WidgetConfigurationIntent
        static let title: LocalizedStringResource = "Title"
        static let description: IntentDescription? = IntentDescription("Description")
        
        // MARK: CustomStringConvertible
        var description: String {
            return route.description
        }
    }
    
    struct Entry: TimelineEntry {
        let route: Route
        let date: Date
        
        init(_ date: Date = Date(), configuration: Intent = Intent()) {
            route = configuration.route.route
            self.date = date
        }
    }
    
    // MARK: AppIntentTimelineProvider
    func recommendations() -> [AppIntentRecommendation<Intent>] {
        return Route.allCases.map { route in
            let intent: Intent = Intent(route)
            return AppIntentRecommendation(intent: intent, description: intent.description)
        }
    }
    
    func placeholder(in context: Context) -> Entry {
        return Entry()
    }

    func snapshot(for configuration: Intent, in context: Context) async -> Entry {
        return Entry(configuration: configuration)
    }
    
    func timeline(for configuration: Intent, in context: Context) async -> Timeline<Entry> {
        let secondsSince1970: Int = Int(Date().timeIntervalSince1970)
        var entries: [Entry] = []
        for second in 0...120 {
            let date: Date = Date(timeIntervalSince1970: TimeInterval(secondsSince1970 + second))
            entries.append(Entry(date, configuration: configuration))
            entries.append(Entry(Date(timeInterval: 0.5, since: date), configuration: configuration))
        }
        return Timeline(entries: entries, policy: .atEnd)
    }
}

import WidgetKit
import AppIntents
import Boats

struct Provider: AppIntentTimelineProvider {
    struct Intent: WidgetConfigurationIntent, CustomStringConvertible {
        @Parameter(title: "Route", default: .peaks) var route: RouteEnum
        
        func fetch() async -> Route {
            do {
                let index: Boats.Index = try await URLSession.shared.index(.fetch)
                return index.routes[route.rawValue]
            } catch {
                return Route.allCases[route.rawValue]
            }
        }
        
        init(_ route: Route) {
            self.route = RouteEnum(route)
        }
        
        init() {
            
        }
        
        // MARK: WidgetConfigurationIntent
        static let title: LocalizedStringResource = "Boats"
        static let description: IntentDescription? = IntentDescription("Upcoming Casco Bay Lines ferry departures for a selected island")
        
        // MARK: CustomStringConvertible
        var description: String {
            return route.description
        }
    }
    
    struct Entry: TimelineEntry {
        let route: Route
        let date: Date
        
        init(_ date: Date = Date(), route: Route = .peaks) {
            self.route = route
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
        let route: Route = await configuration.fetch()
        return Entry(route: route)
    }
    
    func timeline(for configuration: Intent, in context: Context) async -> Timeline<Entry> {
        let route: Route = await configuration.fetch()
        
        var entries: [Entry] = [
            Entry(Date(), route: route)
        ]
        for dayTrip in route.dayTrips() {
            let date: (origin: Date?, destination: Date?) = dayTrip.date
            if let date: Date = date.origin {
                entries.append(Entry(date, route: route))
            }
            if let date: Date = date.destination {
                entries.append(Entry(date, route: route))
            }
        }
        return Timeline(entries: entries, policy: .atEnd)
    }
}

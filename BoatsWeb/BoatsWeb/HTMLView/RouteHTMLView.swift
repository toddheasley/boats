import Foundation
import BoatsKit

class RouteHTMLView: HTMLView, HTMLDataSource {
    private var dateFormatter: DateFormatter!
    
    private(set) var index: Index!
    private(set) var provider: Provider!
    private(set) var route: Route!
    
    init?(index: Index, provider: Provider, route: Route) {
        super.init()
        self.index = index
        self.provider = provider
        self.route = route
        dateFormatter = DateFormatter(localization: index.localization)
        html.dataSource = self
    }
    
    // MARK: HTMLView
    override var name: URI {
        return URI(stringLiteral: "\(provider.uri)-\(route.uri)")
    }
    
    // MARK: HTMLDataSource
    func value(of name: String, at i: [Int], in html: HTML) -> String? {
        switch name {
        case "PROVIDER":
            guard let url = provider.url else {
                return "\(provider.name)"
            }
            return "<a href=\"\(url)\">\(provider.name)</a>"
        case "ROUTE_NAME":
            return "\(route.name)"
        case "SCHEDULE_SEASON":
            guard let schedule = route.schedule() else {
                return "Schedule Unavailable"
            }
            return "\(dateFormatter.string(from: schedule.season, style: .medium))"
        case "DAY":
            guard !i.isEmpty,
                let schedule = route.schedule() else {
                return nil
            }
            return "\(dateFormatter.string(from: schedule.days[i[0]]))"
        case "DIRECTION":
            guard i.count > 1 else {
                return nil
            }
            switch Departure.Direction.all[i[1]] {
            case .destination:
                return "From \(route.origin.name)"
            case .origin:
                return "To \(route.origin.name)"
            }
        case "DEPARTURE_CAR":
            guard i.count > 2,
                let schedule = route.schedule(),
                let departures = route.schedule()?.departures(day: schedule.days[i[0]], direction: Departure.Direction.all[i[1]]) else {
                return nil
            }
            return departures[i[2]].services.contains(.car) ? "\(SVG.car.html)" : ""
        case "DEPARTURE_TIME":
            guard i.count > 2,
                let schedule = route.schedule(),
                let departures = route.schedule()?.departures(day: schedule.days[i[0]], direction: Departure.Direction.all[i[1]]) else {
                return nil
            }
            return "<span>\(dateFormatter.components(from: departures[i[2]].time).joined(separator: "</span><span>"))</span>"
        case "HOLIDAYS":
            guard !i.isEmpty,
                let schedule = route.schedule(), schedule.days[i[0]] == .holiday, !schedule.holidays.isEmpty else {
                return nil
            }
            return schedule.holidays.map { holiday in
                "<span><b>\(holiday.name)</b> \(dateFormatter.string(from: holiday.date, style: .medium))</span>"
            }.joined(separator: " ")
        case "MENU":
            return "<a href=\"\(self.index.uri).html\">\(SVG.menu.html)</a>"
        case "INDEX_NAME":
            return "<a href=\"\(self.index.uri).html\">\(self.index.name)</a>"
        case "INDEX_DESCRIPTION":
            return "\(self.index.description)"
        case "TITLE":
            return "\(route.name) - \(provider.name)"
        case "APP_TITLE":
            return "\(Site.app.name)"
        case "APP_ID":
            return "\(Site.app.identifier!)"
        case "MANIFEST_URI":
            return "\(Manifest().uri.resource)"
        case "BOOKMARK_URI":
            return "\(BookmarkIcon().uri.resource)"
        case "STYLESHEET_URI":
            return "\(Stylesheet().uri.resource)"
        case "SCRIPT_URI":
            return "\(Script().uri.resource)"
        default:
            return nil
        }
    }
    
    func count(of name: String, at i: [Int], in html: HTML) -> Int {
        switch name {
        case "DAY":
            return route.schedule()?.days.count ?? 0
        case "DIRECTION":
            return Departure.Direction.all.count
        case "DEPARTURE":
            guard i.count > 1,
                let schedule = route.schedule() else {
                return 0
            }
            return schedule.departures(day: schedule.days[i[0]], direction: Departure.Direction.all[i[1]]).count
        default:
            return 0
        }
    }
}

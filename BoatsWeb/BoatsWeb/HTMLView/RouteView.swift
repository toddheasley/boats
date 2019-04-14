import Foundation
import BoatsKit

struct RouteView: HTMLView {
    private(set) var route: Route
    private(set) var index: Index
    
    init(route: Route, index: Index) {
        self.route = route
        self.index = index
    }
    
    // MARK: HTMLView
    var uri: String {
        return route.uri
    }
}

extension RouteView: HTMLDataSource {
    
    // MARK: HTMLDataSource
    func template(of name: String, at index: [Int]) -> String? {
        switch name {
        case "ROUTE_NAME":
            return "\(route.name)"
        case "SEASON":
            return route.schedule()?.season.description ?? "Schedule Unavailable"
        case "DAYS":
            guard !index.isEmpty,
                let schedule: Schedule = route.schedule() else {
                return nil
            }
            return schedule.timetables[index[0]].description
        case "INDEX_LOCATION":
            return "<small>Depart \(self.index.location.abbreviated)</small>"
        case "ROUTE_LOCATION":
            return "<small>Depart \(route.location.abbreviated)</small>"
        case "TRIP_ORIGIN", "TRIP_DESTINATION":
            guard index.count > 1,
                let trip: Timetable.Trip = route.schedule()?.timetables[index[0]].trips[index[1]],
                let departure: Departure = (name == "TRIP_ORIGIN" ? trip.origin : trip.destination) else {
                return nil
            }
            let time: String = departure.time.descriptionComponents.map { component in
                return "<b>\(component)</b>"
            }.joined()
            if let deviation: Deviation = departure.deviations.first {
                return "<time>\(time)</time> <small>\(deviation.description.replacingOccurrences(of: " ", with: "<br>"))</small>"
            } else if departure.isCarFerry {
                return "<time>\(time)</time> \((try? SVG.car.html()) ?? SVG.car.description)"
            } else {
                return "<time>\(time)</time>"
            }
        case "MENU":
            return "<a href=\"\(IndexView(index: self.index).path)\">\((try? SVG.menu.html()) ?? SVG.menu.description)</a>"
        case "INDEX_NAME":
            return "<a href=\"\(self.index.url.absoluteString)\">\(self.index.name)</a>"
        case "INDEX_DESCRIPTION":
            return "\(self.index.description)"
        case "TITLE":
            return "\(route.name) - \(Site.name)"
        case "NAME":
            return "\(Site.name)"
        case "APP_ID":
            return Site.appIdentifier
        case "BOOKMARK_PATH":
            return "\(BookmarkIcon().path)"
        case "STYLESHEET_PATH":
            return "\(Stylesheet().path)"
        default:
            return nil
        }
    }
    
    func count(of name: String, at index: [Int]) -> Int {
        switch name {
        case "TIMETABLE":
            return route.schedule()?.timetables.count ?? 0
        case "TRIP":
            return route.schedule()?.timetables[index[0]].trips.count ?? 0
        default:
            return 0
        }
    }
}

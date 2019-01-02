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
            return route.schedule()?.season.description ?? "Schedule unavailable"
        case "DAYS":
            guard !index.isEmpty else {
                return nil
            }
            return route.schedule()?.timetables[index[0]].description
        case "INDEX_LOCATION":
            return "Depart \(self.index.location.name)"
        case "ROUTE_LOCATION":
            return "Depart \(route.location.name)"
        case "TRIP_ORIGIN", "TRIP_DESTINATION":
            guard index.count > 1,
                let trip: Timetable.Trip = route.schedule()?.timetables[index[0]].trips[index[1]],
                let departure: Departure = (name == "TRIP_ORIGIN" ? trip.origin : trip.destination) else {
                return nil
            }
            let time: [String] = departure.time.descriptionComponents.map { component in
                return "<b>\(component)</b>"
            }
            let deviations: [String] = departure.deviations.map { deviation in
                return "<small>\(deviation)</small>"
            }
            return "<time>\(time.joined())</time>\(departure.isCarFerry ? " \((try? SVG.car.html()) ?? SVG.car.description)" : "")\(!deviations.isEmpty ? " <span>\(deviations.joined(separator: " "))</span>" : "")"
        case "HOLIDAYS":
            guard !index.isEmpty,
                let schedule: Schedule = route.schedule(), !schedule.holidays.isEmpty,
                schedule.timetables[index[0]].days.contains(.holiday) else {
                return nil
            }
            return schedule.holidays.map { holiday in
                let components: [String] = holiday.description.components(separatedBy: ": ")
                return components.count == 2 ? "<small><b>\(components.first!)</b> \(components.last!)</small>" : ""
            }.joined(separator: " ")
        case "MENU":
            return "<a href=\"\(IndexView(index: self.index).path)\">\((try? SVG.menu.html()) ?? SVG.menu.description)</a>"
        case "INDEX_NAME":
            return "\(self.index.name)"
        case "INDEX_DESCRIPTION":
            return "\(self.index.description)"
        case "INDEX_URL":
            return "<a href=\"\(self.index.url.absoluteString)\">\(self.index.url.host ?? self.index.url.absoluteString)</a>"
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
        case "SCRIPT_PATH":
            return "\(Script().path)"
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

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
        
        /*
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
                let schedule: Schedule = route.schedule(),
                let departures: [Departure] = route.schedule()?.departures(day: schedule.days[i[0]], direction: Departure.Direction.all[i[1]]) else {
                    return nil
            }
            return departures[i[2]].services.contains(.car) ? "\(SVG.car.html)" : ""
        case "DEPARTURE_TIME":
            guard i.count > 2,
                let schedule: Schedule = route.schedule(),
                let departures: [Departure] = route.schedule()?.departures(day: schedule.days[i[0]], direction: Departure.Direction.all[i[1]]) else {
                    return nil
            }
            return "<span>\(dateFormatter.components(from: departures[i[2]].time).joined(separator: "</span><span>"))</span>" */
            
            
            
            
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
            guard let trip: Timetable.Trip = route.schedule()?.timetables[index[0]].trips[index[1]] else {
                return nil
            }
            if name == "TRIP_ORIGIN", let departure: Departure = trip.origin {
                return "\(departure.time)"
            } else if let departure: Departure = trip.destination {
                return "\(departure.time)"
            }
            return nil
        case "HOLIDAYS":
            guard !index.isEmpty,
                let schedule: Schedule = route.schedule(), !schedule.holidays.isEmpty,
                schedule.timetables[index[0]].days.contains(.holiday) else {
                return nil
            }
            return schedule.holidays.map { holiday in
                let components: [String] = holiday.description.components(separatedBy: ": ")
                return components.count == 2 ? "<span><b>\(components.first!)</b> \(components.last!)</span>" : ""
            }.joined(separator: " ")
        case "MENU":
            return "<a href=\"\(self.index.path)\">\((try? SVG.menu.html()) ?? SVG.menu.description)</a>"
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
        case "MANIFEST_PATH":
            return "\(Manifest().path)"
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

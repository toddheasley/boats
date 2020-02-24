import Foundation
import BoatsKit

struct RouteView: HTMLView {
    let route: Route
    let index: Index
    
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
            return route.name
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
                return "<time>\(time)</time> &#128664;"
            } else {
                return "<time>\(time)</time>"
            }
        case "MENU":
            return "<a href=\"\(IndexView(index: self.index).path)\">&#127968;</a>"
        case "INDEX_NAME":
            return "<a href=\"\(self.index.url.absoluteString)\">\(self.index.name)</a>"
        case "INDEX_DESCRIPTION":
            return "\(index)"
        case "TITLE":
            return "\(route.name) - \(Site.name)"
        case "NAME":
            return Site.name
        case "APP_ID":
            return Site.appIdentifier
        case "BOOKMARKICON_PATH":
            return BookmarkIcon().path
        case "STYLESHEET_PATH":
            return Stylesheet().path
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
    
    // MARK: Resource
    func data() throws -> Data {
        var html: HTML = try HTML(data: HTML_Data)
        html.dataSource = self
        return try html.data()
    }
}

private let HTML_Data: Data = """
<!DOCTYPE html>
<html>
    <head>
        <title><!-- TITLE --></title>
        <meta name="viewport" content="initial-scale=1.0">
        <meta name="apple-mobile-web-app-title" content="<!-- NAME -->">
<!-- APP_ID? -->
        <meta name="apple-itunes-app" content="app-id=<!-- APP_ID -->">
<!-- ?APP_ID -->
        <link rel="apple-touch-icon" href="<!-- BOOKMARKICON_PATH -->">
        <link rel="stylesheet" href="<!-- STYLESHEET_PATH -->">
    </head>
    <body>
        <nav><!-- MENU --></nav>
        <header>
            <h1><!-- INDEX_NAME --></h1>
        </header>
        <main>
            <h1><!-- ROUTE_NAME --></h1>
            <h2><small><!-- SEASON --></small></h2>
<!-- TIMETABLE[ -->
            <section>
                <h3><!-- DAYS --></h3>
                <table>
                    <tr>
                        <th><!-- INDEX_LOCATION --></th>
                        <th><!-- ROUTE_LOCATION --></th>
                    </tr>
<!-- TRIP[ -->
                    <tr>
                        <td><!-- TRIP_ORIGIN --></td>
                        <td><!-- TRIP_DESTINATION --></td>
                    </tr>
<!-- ]TRIP -->
                </table>
            </section>
<!-- ]TIMETABLE -->
        </main>
    </body>
</html>
""".data(using: .utf8)!

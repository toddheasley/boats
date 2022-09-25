import Foundation
import Boats

struct RouteView: HTMLView {
    let route: Route
    let index: Index
    
    init(_ route: Route, index: Index = Index()) {
        self.route = route
        self.index = index
    }
    
    // MARK: HTMLView
    var html: [HTML] {
        return [
            HTML.head(index, title: route.name),
            .main(index, route: route)
        ]
    }
    
    var uri: String {
        return route.uri
    }
}

extension HTML {
    fileprivate static func main(_ index: Boats.Index, route: Route) -> Self {
        var html: [Self] = []
        html.append("<main>")
        html.append("    <h1>\(route.name)</h1>")
        
        if let schedule: Schedule = route.schedule() {
            html.append("    <h2><small>\(schedule.season)</small></h2>")
            for timetable in schedule.timetables {
                html.append("    <table>")
                html.append("        <caption>\(timetable)</caption>")
                html.append("        <tr>")
                html.append("            <th><small>Depart \(index.location.abbreviated)</small></th>")
                html.append("            <th><small>Depart \(route.location.abbreviated)</small></th>")
                html.append("        </tr>")
                for trip in timetable.trips {
                    html.append("        <tr>")
                    html.append("            <td>\(time(trip.origin?.time))</td>")
                    html.append("            <td>\(time(trip.destination?.time))</td>")
                    html.append("        </tr>")
                }
                html.append("    </table>")
            }
        } else {
            html.append("    <h2><small>Schedule Unavailable</small></h2>")
        }
        html.append("</main>")
        return html.joined(separator: "\n")
    }
    
    private static func time(_ time: Time?) -> Self {
        guard let time else {
            return "&nbsp;"
        }
        return "<time>\(time.descriptionComponents.map { "<b>\($0)</b>" }.joined())</time>"
    }
}

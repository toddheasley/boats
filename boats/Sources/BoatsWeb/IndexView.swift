import Foundation
import Boats

struct IndexView: HTMLView {
    let index: Index
    
    init(_ index: Index = Index()) {
        self.index = index
    }
    
    // MARK: HTMLView
    var html: [HTML] {
        var html: [HTML] = HTML.head(index)
        html.append("<h1><a href=\"\(index.url.absoluteString)\">\(index.name)</a></h1>")
        for route in index.routes {
            html.append("<h2 id=\"\(route.uri)\">\(route) <small><a href=\"#\(route.uri)\">#</a></small></h2>")
            if let schedule: Schedule = route.schedule(for: Date(timeIntervalSinceNow: 604800.0)) {
                html.append("<h3>\(schedule.season)</h3>")
                for timetable in schedule.timetables {
                    html += HTML.table(timetable, origin: index.location.name, destination: route.description(.abbreviated))
                }
            } else {
                html.append("<h3>Schedule Unavailable</h3>")
            }
        }
        return html
    }
    
    var uri: String {
        return index.uri
    }
}

extension HTML {
    fileprivate static func table(_ timetable: Timetable, origin: String? = nil, destination: String? = nil) -> [Self] {
        var html: [Self] = []
        html.append("<table>")
        html.append("    <tr>")
        html.append("        <th colspan=\"2\">\(timetable)</th>")
        html.append("    </tr>")
        html.append("    <tr>")
        html.append("        <td><small>Depart \(origin ?? "Origin")</small></td>")
        html.append("        <td><small>Depart \(destination ?? "Destination")</small></td>")
        html.append("    </tr>")
        for trip in timetable.trips {
            html.append("    <tr>")
            html.append("        <td>\(HTML.data(trip.origin))</td>")
            html.append("        <td>\(HTML.data(trip.destination))</td>")
            html.append("    </tr>")
        }
        html.append("</table>")
        return html
    }
    
    private static func data(_ departure: Departure?) -> Self {
        guard let departure else {
            return "&nbsp;"
        }
        var html: [Self] = [
            time(departure.time)
        ]
        if departure.isCarFerry {
            html.append("cf")
        }
        for deviation in departure.deviations {
            html.append(deviation.description(.compact))
        }
        return html.joined(separator: " ")
    }
    
    private static func time(_ time: Time) -> Self {
        return "<time>\(time.components().map { "<b>\($0)</b>" }.joined())</time>"
    }
}

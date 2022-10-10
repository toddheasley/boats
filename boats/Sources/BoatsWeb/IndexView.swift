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
        html.append("<h1>\(HTML.a(index.name, href: index.url.absoluteString))</h1>")
        for (index, route) in index.routes.enumerated() {
            if index > 0 {
                html.append("<hr>")
            }
            html.append("<h2>\(route)</h2>")
            if let schedule: Schedule = route.schedule(for: Date(timeIntervalSinceNow: 604800.0)) {
                html.append("<h3>\(schedule.season)</h3>")
                for timetable in schedule.timetables {
                    html += HTML.table(timetable, origin: self.index.location.name, destination: route.description(.abbreviated))
                }
            } else {
                html.append("<h3>?</h3>")
            }
        }
        return html
    }
    
    var uri: String {
        return index.uri
    }
}

extension HTML {
    static func a(_ html: Self, href: String) -> Self {
        return "<a href=\"\(href)\">\(html)</a>"
    }
    
    static func table(_ timetable: Timetable, origin: String? = nil, destination: String? = nil) -> [Self] {
        var html: [Self] = []
        html.append("<table>")
        html.append("    <caption>\(timetable)</caption>")
        html.append("    <tr>")
        html.append("        <th>Depart \(origin ?? "Origin")</th>")
        html.append("        <th>Depart \(destination ?? "Destination")</th>")
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

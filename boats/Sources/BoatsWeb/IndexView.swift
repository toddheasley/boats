import SwiftUI
import Boats

struct IndexView: HTMLView {
    let index: Index
    
    init(_ index: Index = Index()) {
        self.index = index
    }
    
    // MARK: HTMLView
    var html: [String] {
        var html: [String] = []
        html.append("<!DOCTYPE html>")
        html.append("<meta charset=\"UTF-8\">")
        html.append(meta("viewport", content: "initial-scale=1.0"))
        html.append(meta("apple-mobile-web-app-title", content: Site.name))
        if let appIdentifier: String = Site.appIdentifier, !appIdentifier.isEmpty {
            html.append(meta("apple-itunes-app", content: "app-id=\(appIdentifier)"))
        }
        html.append(meta("og:image", content: URL(string: ShareImage().path, relativeTo: Site.baseURL)!.absoluteString))
        html.append(meta("og:title", content: index.title))
        html.append(link("apple-touch-icon", href: BookmarkIcon().path))
        html.append(link("shortcut icon", href: Favicon().path))
        html.append("<title>\(index.title)</title>")
        html.append("<header>")
        html.append("    <nav><a href=\"javascript:window.print()\">🖨️</a></nav>")
        html.append("    <h1><a href=\"\(index.url.absoluteString)\">\(index.name)</a> \(index.description)</h1>")
        html.append("</header>")
        for route in index.routes {
            html.append("<section>")
            html.append("    <h2 id=\"\(route.uri)\">\(route) <a href=\"#\(route.uri)\">#</a></h2>")
            if let schedule: Schedule = route.schedule(for: Date(timeIntervalSinceNow: 604800.0)) {
                html.append("    <h3>\(schedule.season)</h3>")
                for timetable in schedule.timetables {
                    html += table(timetable, origin: index.location.nickname, destination: route.location.nickname).map { "    \($0)" }
                }
            } else {
                html.append("    <h3>Schedule Unavailable</h3>")
            }
            html.append("</section>")
        }
        html.append("<footer>")
        html.append("    <hr>")
        html.append("    <h4 id=\"privacy\">Privacy</h4>")
        html.append("    <h2>Data Not Collected</h2>")
        html.append("    <p>Boats is available for Apple platforms and follows <a href=\"https://www.apple.com/privacy\">Apple privacy</a> guidelines and labeling.</p>")
        html.append("    <p>Schedule data is scraped from <a href=\"https://www.cascobaylines.com\">cascobaylines.com</a> and hosted with <a href=\"https://pages.github.com\">GitHub&nbsp;Pages.</a> The entire Boats source code is <a href=\"https://github.com/toddheasley/boats\">publicly available on GitHub</a> under the <a href=\"https://choosealicense.com/licenses/mit\">MIT&nbsp;License.</a></p>")
        html.append("</footer>")
        html.append(style)
        return html
    }
    
    var uri: String {
        return index.uri
    }
}

private extension Index {
    var title: String {
        return "\(name) \(description)"
    }
}

private func meta(_ name: String, content: String) -> String {
    return "<meta name=\"\(name)\" content=\"\(content)\">"
}

private func link(_ rel: String, href: String) -> String {
    return "<link rel=\"\(rel)\" href=\"\(href)\">"
}

private func table(_ timetable: Timetable, origin: String? = nil, destination: String? = nil) -> [String] {
    var html: [String] = []
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
        html.append("        <td>\(data(trip.origin))</td>")
        html.append("        <td>\(data(trip.destination))</td>")
        html.append("    </tr>")
    }
    html.append("</table>")
    return html
}

private func data(_ departure: Departure?) -> String {
    guard let departure else {
        return ""
    }
    var html: [String] = [
        time(departure.time)
    ]
    var description: String = departure.deviations.isEmpty ? "" : departure.description.replacingOccurrences(of: departure.time.description, with: "")
    if departure.isCarFerry {
        description = description.replacingOccurrences(of: " \(Service.car)", with: "")
        html.append(Service.car.emoji)
    }
    description = description.trimmingCharacters(in: .whitespacesAndNewlines)
    if !description.isEmpty {
        html.append("<small>\(description.trimmingCharacters(in: .whitespacesAndNewlines))</small>")
    }
    return html.joined(separator: " ")
}

private func time(_ time: Time) -> String {
    return "<time>\(time.components().map { "<b>\($0)</b>" }.joined())</time>"
}

private let style: String = """
<style>
    
    :root {
        color-scheme: light dark;
        --background-color: \(Color(255));
    }
    
    @media (prefers-color-scheme: dark) {
        :root {
            --background-color: \(Color.navy);
        }
    }
    
    a {
        color: \(Color.link);
    }
    
    a[href^="javascript:"] {
        text-decoration: none;
    }
    
    body {
        background: var(--background-color);
        font: 1em ui-sans-serif, sans-serif;
    }
    
    h1, h3, h4 {
        font-size: 1em;
    }
    
    h2 {
        font-size: 1.25em;
    }
    
    h2 a {
        font-size: 1em;
    }
    
    header {
        position: relative;
    }
    
    nav {
        position: absolute;
        right: 0;
    }
    
    small {
        font-size: 0.5em;
        text-transform: uppercase;
    }
    
    table {
        border-collapse: collapse;
        overflow: hidden;
        width: 288px;
    }

    td {
        vertical-align: top;
        width: 50%;
    }

    td, th {
        border: 1px solid;
        overflow: hidden;
        text-align: left;
        white-space: nowrap;
    }
    
    tr:nth-child(odd) {
        background: \(Color.haze);
    }
    
    tr:first-child {
        background: none;
    }
    
    td small {
        display: block;
    }

    time b {
        display: inline-block;
        font-size: 1.5em;
        text-align: center;
        width: 0.75em;
    }

    time b:nth-child(3), time b:last-child {
        width: 0.35em;
    }
    
    @media print {
        a, section, table {
            page-break-inside: avoid;
        }
        
        a {
            color: inherit;
            text-decoration: none;
        }
        
        a[href^="javascript:"], a[href^="#"] {
            display: none;
        }
    }
    
</style>
"""

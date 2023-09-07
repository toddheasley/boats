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
        html.append("<h1><a href=\"\(index.url.absoluteString)\">\(index.name)</a> \(index.description) <a href=\"javascript:window.print()\">🖨️</a></h1>")
        html.append("<article>")
        for route in index.routes {
            html.append("    <section>")
            html.append("        <h2 id=\"\(route.uri)\"><em>\(route)</em> <a href=\"#\(route.uri)\">#</a></h2>")
            if let schedule: Schedule = route.schedule(for: Date(timeIntervalSinceNow: 604800.0)) {
                html.append("        <h3>\(schedule.season)</h3>")
                html.append("        <article>")
                for timetable in schedule.timetables {
                    html += table(timetable, origin: index.location.nickname, destination: route.location.nickname).map { "            \($0)" }
                }
                html.append("        </article>")
            } else {
                html.append("        <h3>Schedule unavailable</h3>")
            }
            html.append("    </section>")
        }
        html.append("</article>")
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
    if departure.isCarFerry {
        html.append(Service.car.emoji)
    }
    if !departure.deviations.isEmpty {
        html.append("<small>\(departure.components()[2])</small>")
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
        --foreground-color: \(Color.navy);
        -webkit-text-size-adjust: 100%;
    }
    
    @media (prefers-color-scheme: dark) {
        :root {
            --background-color: \(Color.navy);
            --foreground-color: \(Color(255));
        }
    }
    
    * {
        margin: 0;
    }
    
    body {
        font-family: ui-sans-serif, sans-serif;
    }
    
    h1, h2, h3, h4, table {
        font-size: 1em;
    }
    
    h2 em {
        font-size: 1.25em;
    }
    
    h3 {
        font-weight: normal;
    }
    
    h3 b {
        font-size: 1.25em;
        font-weight: normal;
        opacity: 0.9;
    }
    
    small {
        font-size: 0.7em;
        text-transform: uppercase;
    }
    
    table, td, th {
        overflow: hidden;
        text-align: left;
        white-space: nowrap;
    }
    
    td {
        position: relative;
        vertical-align: top;
        width: 50%;
    }
    
    td small {
        display: block;
        margin-left: 0.25em;
    }
    
    time b {
        display: inline-block;
        font-size: 2em;
        text-align: center;
        width: 0.75em;
    }
    
    time b:nth-child(3), time b:last-child {
        width: 0.35em;
    }
    
    @media screen {
        a {
            color: \(Color.link);
        }
        
        a[href^="javascript:"] {
            font-size: 2em;
            position: absolute;
            right: 0;
            text-decoration: none;
        }
        
        article {
            display: flex;
            flex-wrap: wrap;
        }
        
        body {
            background: var(--background-color);
            font-size: 15px;
            margin: 1em auto;
            width: 320px;
        }
        
        @media (min-width: 640px) {
            body {
                width: 640px;
            }
        }
        
        @media (min-width: 960px) {
            body {
                width: 960px;
            }
        }
        
        @media (min-width: 1280px) {
            body {
                width: 1280px;
            }
        }
        
        h1, h2, h3, h4, table {
            margin: 0.5em 8px;
        }
        
        h1 {
            position: relative;
        }
        
        h2 em {
            color: \(Color.gold);
            font-size: 1.5em;
            letter-spacing: 0.5px;
            text-shadow: -1px 1px \(Color(0, alpha: 0.5));
        }
        
        section {
            margin: 2em 0;
        }
        
        table {
            display: flex;
        }
        
        td, th {
            width: 146px;
        }
        
        td time + small {
            background: \(Color.aqua);
            border-radius: 0.25em;
            bottom: 2.5px;
            box-shadow: -1px 1px \(Color(0, alpha: 0.5));
            color: \(Color(0));
            left: 1.5px;
            padding: 0.2em;
            position: absolute;
        }
        
        th {
            background: var(--foreground-color);
            border-radius: 0.5em 0.5em 0 0;
            color: var(--background-color);
            padding: 5px;
        }
        
        tr:last-child td:first-child {
            border-radius: 0 0 0 0.5em;
        }
        
        tr:last-child td:last-child {
            border-radius: 0 0 0.5em 0;
        }
        
        tr:nth-child(odd) {
            background: \(Color.haze);
        }
        
        tr:nth-child(2) {
            background: \(Color.aqua);
            color: \(Color(0));
        }
    }
    
    @media print {
        a {
            color: inherit;
            text-decoration: none;
        }
        
        a[href^="javascript:"], a[href^="#"] {
            display: none;
        }
        
        body {
            font-size: 10pt;
        }
        
        h1 {
            display: none;
        }
        
        h2, h3, h4, table {
            margin: 0.5em 0;
        }
        
        section {
            margin: 4em 0;
            page-break-after: always;
        }
        
        table {
            display: inline-table;
            width: 204pt;
        }
        
        table + table {
            margin-left: 1em;
        }
        
        td, th {
            border: 0.5pt solid;
        }
    }
    
</style>
"""

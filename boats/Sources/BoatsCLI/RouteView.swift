import Boats

struct RouteView: TextView {
    let route: Route
    let origin: Location
    
    init(_ route: Route, origin: Location? = nil) {
        self.route = route
        self.origin = origin ?? Index().location
    }
    
    // MARK: TextView
    var text: [Text] {
        let schedules: [Schedule] = route.schedules()
        var text: [Text] = []
        text.append(route.description)
        if !schedules.isEmpty {
            for (index, schedule) in schedules.enumerated() {
                if index > 0 {
                    text.append("")
                }
                text.append("[\(schedule.season)]")
                for (index, timetable) in schedule.timetables.enumerated() {
                    if index > 0 {
                        text.append("")
                    }
                    text.append(timetable.description)
                    text.append(Text.row(2))
                    text.append(Text.row([
                        "Depart \(origin.name)",
                        "Depart \(route.description(.abbreviated))"
                    ]))
                    text.append(Text.row(2))
                    for trip in timetable.trips {
                        text.append(Text.row([
                            DepartureView(trip.origin).description,
                            DepartureView(trip.destination).description
                        ]))
                    }
                    text.append(Text.row(2))
                }
            }
        } else {
            text.append("[?]")
        }
        text.append("")
        return text
    }
}

extension Int {
    fileprivate static let count: Self = 22
}

extension Text {
    fileprivate static func row(_ segments: [String], columns count: Int = .count) -> Self {
        guard !segments.isEmpty else {
            return ""
        }
        return "| \(segments.map { $0.padded(to: count)}.joined(separator: " | ")) |"
    }
    
    fileprivate static func row(_ segments: Int = 1, columns count: Int = .count) -> Self {
        guard segments > 0 else {
            return ""
        }
        let segment: String = String(repeating: "-", count: count + 2)
        return "+\(Array(repeating: segment, count: segments).joined(separator: "+"))+"
    }
}

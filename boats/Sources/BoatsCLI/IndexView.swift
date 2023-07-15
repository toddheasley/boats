import Boats
import BoatsWeb

struct IndexView: TextView {
    let index: Index
    
    init(_ index: Index) {
        self.index = index
    }
    
    // MARK: TextView
    var text: [String] {
        var text: [String] = []
        text.append("")
        text.append(Site(index).description)
        text.append(index.url.absoluteString)
        text.append("")
        for route in index.routes {
            let schedules: [Schedule] = route.schedules()
            text.append(route.description)
            if !schedules.isEmpty {
                for schedule in schedules {
                    text.append(schedule.season.description)
                    for timetable in schedule.timetables {
                        text += table(timetable, origin: index.location.nickname, destination: route.location.nickname)
                        text.append("")
                    }
                }
            } else {
                text.append("Schedule unavailable")
                text.append("")
            }
        }
        return text
    }
}

private func table(_ timetable: Timetable, origin: String? = nil, destination: String? = nil) -> [String] {
    var text: [String] = []
    text.append(row(columns: 47))
    text.append(row([
        timetable.description
    ], columns: 47))
    text.append(row(2, columns: 22))
    text.append(row([
        "Depart \(origin ?? "origin")",
        "Depart \(destination ?? "destination")"
    ], columns: 22))
    text.append(row(2, columns: 22))
    for trip in timetable.trips {
        text.append(row([
            data(trip.origin),
            data(trip.destination)
        ], columns: 22))
    }
    text.append(row(2, columns: 22))
    return text
}
    
private func data(_ departure: Departure?) -> String {
        return departure?.description ?? ""
}

private func row(_ segments: [String], columns count: Int) -> String {
    guard !segments.isEmpty else {
        return ""
    }
    return "| \(segments.map { $0.padded(to: count)}.joined(separator: " | ")) |"
}

private func row(_ segments: Int = 1, columns count: Int) -> String {
    guard segments > 0 else {
        return ""
    }
    let segment: String = String(repeating: "-", count: count + 2)
    return "+\(Array(repeating: segment, count: segments).joined(separator: "+"))+"
}

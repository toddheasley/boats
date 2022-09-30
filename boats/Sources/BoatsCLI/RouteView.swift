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
        text.append(route.name)
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
                    text.append("+-----------------------+-----------------------+")
                    text.append("| Depart \(origin.abbreviated.padded(to: 14)) | Depart \(route.location.abbreviated.padded(to: 14)) |")
                    text.append("+-----------------------+-----------------------+")
                    for trip in timetable.trips {
                        text.append("| \(DepartureView(trip.origin).description.padded(to: 21)) | \(DepartureView(trip.destination).description.padded(to: 21)) |")
                    }
                    text.append("+-----------------------+-----------------------+")
                }
            }
        } else {
            text.append("[Schedule unavailable]")
        }
        text.append("")
        return text
    }
}

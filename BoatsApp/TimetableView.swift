import SwiftUI
import BoatsWeb
import Boats

struct TimetableView: View {
    let timetable: Timetable
    let origin: Location?
    let destination: Location?
    
    init(_ timetable: Timetable, origin: Location? = nil, destination: Location? = nil) {
        self.timetable = timetable
        self.origin = origin
        self.destination = destination
    }
    
    // MARK: View
    var body: some View {
        Section(content: {
            VStack(spacing: .spacing) {
                ForEach(timetable.trips) { trip in
                    Row(trip)
                }
            }
        }, header: {
            Header(timetable.description, origin: origin, destination: destination)
        })
    }
}

struct TimetableView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        TimetableView(try! JSONDecoder().decode(Timetable.self, from: _data), origin: .portland, destination: .peaks)
    }
}

// MARK: Header
private struct Header: View {
    let origin: Location?
    let destination: Location?
    let title: String?
    
    init(_ title: String? = nil, origin: Location? = nil, destination: Location? = nil) {
        self.origin = origin
        self.destination = destination
        self.title = title
    }
    
    // MARK: View
    var body: some View {
        VStack(spacing: .spacing) {
            if let title, !title.isEmpty {
                Cell {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white, dark: .navy)
                        .padding(EdgeInsets(top: 8.0, leading: 4.0, bottom: 5.0, trailing: 4.0))
                }
                .backgroundColor(.navy, dark: .white.opacity(0.95))
            }
            HStack(spacing: .spacing) {
                HeaderCell("Depart \(origin?.nickname ?? "origin")")
                HeaderCell("Depart \(destination?.nickname ?? "destination")")
            }
        }
    }
}

struct Header_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        VStack {
            Header("Mon-Thu/Sat", destination: .peaks)
        }
    }
}

private struct HeaderCell: View {
    let content: String
    
    init(_ content: String = "") {
        self.content = content.isEmpty ? " " : content
    }
    
    // MARK: View
    var body: some View {
        Cell {
            Text(content)
                .lineLimit(1)
                .textCase(.uppercase)
                .font(.system(size: 9.5))
                .foregroundColor(.black)
                .padding(2.0)
        }
        .backgroundColor(.aqua)
    }
}

struct HeaderCell_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        VStack {
            HeaderCell("Depart Peaks")
        }
    }
}

// MARK: Row
private struct Row: View {
    let trip: Timetable.Trip
    
    init(_ trip: Timetable.Trip) {
        self.trip = trip
    }
    
    // MARK: View
    var body: some View {
        HStack(alignment: .center, spacing: .spacing) {
            Cell {
                DepartureView(trip.origin)
            }
            Cell {
                DepartureView(trip.destination)
            }
        }
    }
}

struct Row_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        VStack {
            Row(Timetable.Trip(origin: Departure(Time(hour: 22, minute: 9), services: [
                    .car
                ]), destination: Departure(Time(hour: 22, minute: 9), services: [
                    .car
                ])))
                .backgroundColor(.haze)
            Row(Timetable.Trip(destination: Departure(Time(hour: 22, minute: 9), deviations: [
                    .only(.saturday)
                ])))
                .backgroundColor(.haze)
        }
    }
}

// MARK: Cell
private struct Cell<Content: View>: View {
    let alignment: HorizontalAlignment
    let content: () -> Content
    
    init(alignment: HorizontalAlignment = .leading, @ViewBuilder content: @escaping () -> Content) {
        self.alignment = alignment
        self.content = content
    }
    
    // MARK: View
    var body: some View {
        HStack {
            if alignment != .leading {
                Spacer()
            }
            content()
            if alignment != .trailing {
                Spacer()
            }
        }
    }
}

struct Cell_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        Cell {
            DepartureView(Departure(Time(hour: 22, minute: 9), services: [
                    .car
                ]))
        }
        .backgroundColor(.haze)
    }
}

private extension CGFloat {
    static let spacing: Self = 3.5
}

private let _data: Data = """
{
    "trips": [
        {
            "origin": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 45,
                    "hour": 5
                },
                "deviations": []
            },
            "destination": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 15,
                    "hour": 6
                },
                "deviations": []
            }
        },
        {
            "origin": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 45,
                    "hour": 6
                },
                "deviations": []
            },
            "destination": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 15,
                    "hour": 7
                },
                "deviations": []
            }
        },
        {
            "origin": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 45,
                    "hour": 7
                },
                "deviations": []
            },
            "destination": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 15,
                    "hour": 8
                },
                "deviations": []
            }
        },
        {
            "destination": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 0,
                    "hour": 10
                },
                "deviations": []
            }
        },
        {
            "origin": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 45,
                    "hour": 10
                },
                "deviations": []
            },
            "destination": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 15,
                    "hour": 11
                },
                "deviations": []
            }
        }
    ],
    "days": [
        "monday",
        "tuesday",
        "wednesday",
        "thursday"
    ]
}
""".data(using: .utf8)!

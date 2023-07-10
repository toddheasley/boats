import SwiftUI
import Boats

struct TimetableView: View {
    init(_ timetable: Timetable, origin: Location? = nil, destination: Location? = nil, offset: CGPoint = .zero) {
        self.timetable = timetable
        self.origin = origin
        self.destination = destination
        self.offset = offset
    }
    
    private let timetable: Timetable
    private let origin: Location?
    private let destination: Location?
    private let offset: CGPoint
    
    // MARK: View
    var body: some View {
        Section(content: {
            VStack(spacing: .cellSpacing) {
                ForEach(timetable.trips) { trip in
                    Row(trip)
                }
            }
            .cellPadding()
            .background {
                Color.primary
            }
        }, header: {
            Header(timetable.description, origin: origin, destination: destination)
                .cellPadding()
                .background {
                    Color.primary
                }
        }, footer: {
            Text(" ")
        })
    }
}

/*
struct TimetableView_Previews: PreviewProvider {
    @StateObject private static var index: ObservableIndex = ObservableIndex()
    
    // MARK: PreviewProvider
    static var previews: some View {
        TimetableView(.preview, origin: index.location, destination: .peaks)
                .padding()
    }
} */

private extension Timetable {
    static var preview: Self {
        let decoder: JSONDecoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return try! decoder.decode(Self.self, from: Timetable_JSON)
    }
}

private let Timetable_JSON: Data = """
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


// MARK: Header
private struct Header: View {
    init(_ title: String, origin: Location? = nil, destination: Location? = nil) {
        self.origin = origin
        self.destination = destination
        self.title = title
    }
    
    private let origin: Location?
    private let destination: Location?
    private let title: String
    
    // MARK: View
    var body: some View {
        VStack(alignment: .center, spacing: .cellSpacing) {
            Cell {
                Text(title)
                    .font(.title)
                    .lineLimit(1)
            }
            HStack(alignment: .center, spacing: .cellSpacing) {
                Cell {
                    Text("Depart \(origin?.description(.compact) ?? "Origin")")
                        .lineLimit(1)
                }
                Cell {
                    Text("Depart \(destination?.description(.compact) ?? "Destination")")
                        .lineLimit(1)
                }
            }
        }
    }
}

struct Header_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        Header("Mon-Thu/Sat", destination: .peaks)
            .cellPadding()
            .background {
                Color.previewColor
            }
            .padding()
    }
}

// MARK: Row
private struct Row: View {
    init(_ trip: Timetable.Trip) {
        self.trip = trip
    }
    
    private let trip: Timetable.Trip
    
    // MARK: View
    var body: some View {
        HStack(alignment: .center, spacing: .cellSpacing) {
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
    private static let origin: Departure = Departure(Time(hour: 17, minute: 35), services: [
        .car
    ])
    
    // MARK: PreviewProvider
    static var previews: some View {
        Row(Timetable.Trip(origin: origin, destination: nil))
            .cellPadding()
            .background {
                Color.previewColor
            }
            .padding()
    }
}

// MARK: Cell
private struct Cell<Content: View>: View {
    init(alignment: HorizontalAlignment = .leading, @ViewBuilder content: @escaping () -> Content) {
        self.alignment = alignment
        self.content = content
    }
    
    private let alignment: HorizontalAlignment
    private let content: () -> Content
    
    // MARK: View
    var body: some View {
        HStack {
            if alignment != .leading {
                Spacer()
            }
            content()
                .padding()
            if alignment != .trailing {
                Spacer()
            }
        }
        .backgroundColor()
    }
}

struct Cell_Previews: PreviewProvider {
    private static let departure: Departure = Departure(Time(hour: 17, minute: 35))
    
    // MARK: PreviewProvider
    static var previews: some View {
        Cell {
            DepartureView(departure)
        }
        .cellPadding()
        .background {
            Color.previewColor
        }
        .padding()
    }
}

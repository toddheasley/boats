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
        
        trips = (Array(timetable.trips.dropLast()), timetable.trips.last)
    }
    
    private let trips: (content: [Timetable.Trip], footer: Timetable.Trip?)
    
    // MARK: View
    var body: some View {
        Section(content: {
            VStack(spacing: .spacing) {
                ForEach(trips.content.indices, id: \.self) { index in
                    Row(trips.content[index], index: index)
                }
            }
        }, header: {
            Header(timetable.description, origin: origin, destination: destination)
                .clipShape(
                    .rect(
                        topLeadingRadius: 10.0,
                        bottomLeadingRadius: 0.0,
                        bottomTrailingRadius: 0.0,
                        topTrailingRadius: 10.0
                    )
                )
                .padding(.top)
                .backgroundColor()
        }, footer: {
            if let trip = trips.footer {
                Row(trip, index: trips.content.count)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 0.0,
                            bottomLeadingRadius: 10.0,
                            bottomTrailingRadius: 10.0,
                            topTrailingRadius: 0.0
                        )
                    )
                    .padding(.bottom)
            }
        })
    }
}

#Preview("Timetable View") {
    VStack(spacing: .spacing) {
        TimetableView(try! JSONDecoder().decode(Timetable.self, from: _data))
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
    
    private var insets: EdgeInsets {
#if os(watchOS)
        return EdgeInsets(top: 2.0, leading: 3.5, bottom: 1.0, trailing: 3.5)
#else
        return EdgeInsets(top: 7.5, leading: 5.0, bottom: 6.0, trailing: 5.0)
#endif
    }
    
    // MARK: View
    var body: some View {
        VStack(spacing: .spacing) {
            if let title, !title.isEmpty {
                Cell {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white, dark: .navy)
                        .padding(insets)
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

#Preview("Header") {
    Header("Mon-Thu/Sat", destination: .peaks)
}

// MARK: HeaderCell
private struct HeaderCell: View {
    let content: String
    
    init(_ content: String = "") {
        self.content = content.isEmpty ? " " : content
    }
    
    // MARK: View
    var body: some View {
        Cell {
            Text(content)
                .tiny()
                .lineLimit(1)
                .foregroundColor(.black)
                .padding(2.0)
        }
        .backgroundColor(.aqua)
    }
}

#Preview("Header Cell") {
    VStack(spacing: .spacing) {
        HeaderCell("Depart Peaks")
            .backgroundColor(.haze)
        HeaderCell()
            .backgroundColor(.haze)
    }
}

// MARK: Row
private struct Row: View {
    let trip: Timetable.Trip
    let index: Int?
    
    init(_ trip: Timetable.Trip, index: Int? = nil) {
        self.trip = trip
        self.index = index
        color = (index ?? 0) % 2 == 0 ? .haze : .clear
    }
    
    private let color: Color
    
    // MARK: View
    var body: some View {
        HStack(alignment: .center, spacing: .spacing) {
            Cell {
                DepartureView(trip.origin)
            }
            .backgroundColor(color)
            Cell {
                DepartureView(trip.destination)
            }
            .backgroundColor(color)
        }
    }
}

#Preview("Row") {
    VStack(spacing: .spacing) {
        Row(Timetable.Trip(origin: Departure(Time(hour: 22, minute: 9), services: [
                .car
            ]), destination: Departure(Time(hour: 22, minute: 9), services: [
                .car
            ])))
        Row(Timetable.Trip(destination: Departure(Time(hour: 22, minute: 9), deviations: [
                .only(.saturday)
            ])))
    }
}

// MARK: Cell
struct Cell<Content: View>: View {
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

#Preview("Cell") {
    VStack(spacing: .spacing) {
        Cell {
            DepartureView(Departure(Time(hour: 22, minute: 9), services: [
                .car
            ]))
        }
        .backgroundColor(.haze)
        Cell {
            DepartureView()
        }
        .backgroundColor(.haze)
    }
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

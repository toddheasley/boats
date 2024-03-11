import SwiftUI
import BoatsWeb
import Boats

struct TimetableView: View {
    let timetable: Timetable
    let origin: Location
    let destination: Location
    
    init(_ timetable: Timetable, origin: Location = .portland, destination: Location) {
        self.timetable = timetable
        self.origin = origin
        self.destination = destination
        
        trips = (Array(timetable.trips.dropLast()), timetable.trips.last)
    }
    
    private let trips: (content: [Timetable.Trip], footer: Timetable.Trip?)
    
    // MARK: View
    var body: some View {
#if os(tvOS)
        VStack(spacing: .spacing) {
            Header(timetable.description, origin: origin, destination: destination)
                .clipped()
            ForEach(timetable.trips.indices, id: \.self) { index in
                TripView(timetable.trips[index], index: index)
            }
        }
        .clipped(corners: 10.0)
#else
        Section(content: {
            VStack(spacing: .spacing) {
                ForEach(trips.content.indices, id: \.self) { index in
                    TripView(trips.content[index], destination: destination, index: index)
                }
            }
        }, header: {
            Header(timetable, origin: origin, destination: destination)
                .clipped(corners: [10.0, 0.0, 0.0, 10.0])
                .padding(.top)
                .backgroundColor()
        }, footer: {
            if let trip = trips.footer {
                TripView(trip, destination: destination, index: trips.content.count)
                    .clipped(corners: [0.0, 10.0, 10.0, 0.0])
                    .padding(.bottom)
            }
        })
#endif
    }
}

#Preview("Timetable View") {
    VStack(spacing: .spacing) {
        TimetableView(try! JSONDecoder().decode(Timetable.self, from: _data), origin: .portland, destination: .peaks)
    }
}

// MARK: Header
private struct Header: View {
    let timetable: Timetable?
    let origin: Location?
    let destination: Location?
    
    init(_ timetable: Timetable? = nil, origin: Location? = nil, destination: Location? = nil) {
        self.timetable = timetable
        self.origin = origin
        self.destination = destination
    }
    
    private var insets: EdgeInsets {
#if os(watchOS)
        return EdgeInsets(top: 2.0, leading: 3.5, bottom: 2.0, trailing: 3.5)
#else
        return EdgeInsets(top: 7.5, leading: 5.0, bottom: 6.0, trailing: 5.0)
#endif
    }
    
    // MARK: View
    var body: some View {
        VStack(spacing: .spacing) {
            if let timetable {
                Cell {
                    Text(timetable.description)
                        .font(.table)
                        .foregroundColor(.white, dark: .navy)
                        .padding(insets)
                        .accessibilityLabel(timetable.accessibilityDescription)
                }
                .backgroundColor(.navy, dark: .white.opacity(0.95))
            }
            HStack(spacing: .spacing) {
                TripLabel(origin)
                TripLabel(destination)
            }
            .accessibilityHidden(true)
        }
    }
}

#Preview("Header") {
    Header(try? JSONDecoder().decode(Timetable.self, from: _data), origin: .portland, destination: .peaks)
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

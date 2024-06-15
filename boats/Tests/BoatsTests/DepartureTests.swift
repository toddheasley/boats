import Testing
@testable import Boats
import Foundation

struct DepartureTests {
    @Test func IsCarFerry() {
        #expect(Departure(Time(hour: 9, minute: 41), services: [.car]).isCarFerry)
        #expect(!Departure(Time(hour: 9, minute: 41)).isCarFerry)
    }
    
    @Test func Components() {
        DateFormatter.clockFormat = .twelveHour
        #expect(Departure(Time(hour: 9, minute: 41), deviations: [.start(Date(timeIntervalSince1970: 1540958400.0)), .except(.sunday)]).components() == [" 9:41 ", "", "starts 10/31; except Sun"])
        #expect(Departure(Time(hour: 9, minute: 41), deviations: [.start(Date(timeIntervalSince1970: 1540958400.0)), .except(.sunday)]).components(empty: " ") == [" 9:41 ", " ", "starts 10/31; except Sun"])
        #expect(Departure(Time(hour: 9, minute: 41), deviations: [.start(Date(timeIntervalSince1970: 1540958400.0)), .except(.sunday)]).components(empty: nil) == [" 9:41 ", "starts 10/31; except Sun"])
        #expect(Departure(Time(hour: 21, minute: 41), deviations: [.end(Date(timeIntervalSince1970: 1540958400.0))], services: [.car]).components() == [" 9:41.", "car", "ended 10/31"])
        #expect(Departure(Time(hour: 21, minute: 41), deviations: [.end(Date(timeIntervalSince1970: 1540958400.0))], services: [.car]).components(empty: " ") == [" 9:41.", "car", "ended 10/31"])
        #expect(Departure(Time(hour: 21, minute: 41), deviations: [.end(Date(timeIntervalSince1970: 1540958400.0))], services: [.car]).components(empty: nil) == [" 9:41.", "car", "ended 10/31"])
        #expect(Departure(Time(hour: 21, minute: 41), services: [.car]).components() == [" 9:41.", "car", ""])
        #expect(Departure(Time(hour: 21, minute: 41), services: [.car]).components(empty: "&nbsp;") == [" 9:41.", "car", "&nbsp;"])
        #expect(Departure(Time(hour: 21, minute: 41), services: [.car]).components(empty: nil) == [" 9:41.", "car"])
        #expect(Departure(Time(hour: 21, minute: 41)).components() == [" 9:41.", "", ""])
        #expect(Departure(Time(hour: 21, minute: 41)).components(empty: "_") == [" 9:41.", "_", "_"])
        #expect(Departure(Time(hour: 21, minute: 41)).components(empty: nil) == [" 9:41."])
        DateFormatter.clockFormat = .system
    }
    
    // MARK: CustomAccessibilityStringConvertible
    @Test func AccessibilityDescription() {
        DateFormatter.clockFormat = .twelveHour
        #expect(Departure(Time(hour: 9, minute: 41), deviations: [.start(Date(timeIntervalSince1970: 1540958400.0)), .except(.sunday), .except(.monday)]).accessibilityDescription == "9:41AM starts 10/31; except Monday and Sunday")
        #expect(Departure(Time(hour: 21, minute: 41), deviations: [.end(Date(timeIntervalSince1970: 1540958400.0))], services: [.car]).accessibilityDescription == "9:41PM car ended 10/31")
        #expect(Departure(Time(hour: 21, minute: 41), services: [.car]).accessibilityDescription == "9:41PM car")
        #expect(Departure(Time(hour: 21, minute: 41)).accessibilityDescription == "9:41PM")
        DateFormatter.clockFormat = .system
    }
    
    @Test func Description() {
        DateFormatter.clockFormat = .twelveHour
        #expect(Departure(Time(hour: 9, minute: 41), deviations: [.start(Date(timeIntervalSince1970: 1540958400.0)), .except(.sunday), .except(.monday)]).description == " 9:41  starts 10/31; except Mon/Sun")
        #expect(Departure(Time(hour: 21, minute: 41), deviations: [.end(Date(timeIntervalSince1970: 1540958400.0))], services: [.car]).description == " 9:41. car ended 10/31")
        #expect(Departure(Time(hour: 21, minute: 41), services: [.car]).description == " 9:41. car")
        #expect(Departure(Time(hour: 21, minute: 41)).description == " 9:41.")
        DateFormatter.clockFormat = .system
    }
}

extension DepartureTests {
    
    // MARK: HTMLConvertible
    @Test func HTMLInit() throws {
        #expect(try Departure(from: "AM9:41 fso").time == Time(hour: 9, minute: 41))
        #expect(try Departure(from: "AM9:41 fso").deviations == [.only(.friday), .only(.saturday)])
        #expect(try Departure(from: "AM9:41 fso").services == [])
        #expect(try Departure(from: "AM9:41 cf xf").time == Time(hour: 9, minute: 41))
        #expect(try Departure(from: "AM9:41 cf xf").deviations == [.except(.friday)])
        #expect(try Departure(from: "AM9:41 cf xf").services == [.car])
        #expect(try Departure(from: "PM9:41").time == Time(hour: 21, minute: 41))
        #expect(try Departure(from: "PM9:41").deviations == [])
        #expect(try Departure(from: "PM9:41").services == [])
    }
}

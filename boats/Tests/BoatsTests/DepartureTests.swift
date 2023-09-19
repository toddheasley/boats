import XCTest
@testable import Boats

class DepartureTests: XCTestCase {
    func testIsCarFerry() {
        XCTAssertTrue(Departure(Time(hour: 9, minute: 41), services: [.car]).isCarFerry)
        XCTAssertFalse(Departure(Time(hour: 9, minute: 41)).isCarFerry)
    }
    
    func testComponents() {
        DateFormatter.clockFormat = .twelveHour
        XCTAssertEqual(Departure(Time(hour: 9, minute: 41), deviations: [.start(Date(timeIntervalSince1970: 1540958400.0)), .except(.sunday)]).components(), [" 9:41 ", "", "starts 10/31; except Sun"])
        XCTAssertEqual(Departure(Time(hour: 9, minute: 41), deviations: [.start(Date(timeIntervalSince1970: 1540958400.0)), .except(.sunday)]).components(empty: " "), [" 9:41 ", " ", "starts 10/31; except Sun"])
        XCTAssertEqual(Departure(Time(hour: 9, minute: 41), deviations: [.start(Date(timeIntervalSince1970: 1540958400.0)), .except(.sunday)]).components(empty: nil), [" 9:41 ", "starts 10/31; except Sun"])
        XCTAssertEqual(Departure(Time(hour: 21, minute: 41), deviations: [.end(Date(timeIntervalSince1970: 1540958400.0))], services: [.car]).components(), [" 9:41.", "car", "ended 10/31"])
        XCTAssertEqual(Departure(Time(hour: 21, minute: 41), deviations: [.end(Date(timeIntervalSince1970: 1540958400.0))], services: [.car]).components(empty: " "), [" 9:41.", "car", "ended 10/31"])
        XCTAssertEqual(Departure(Time(hour: 21, minute: 41), deviations: [.end(Date(timeIntervalSince1970: 1540958400.0))], services: [.car]).components(empty: nil), [" 9:41.", "car", "ended 10/31"])
        XCTAssertEqual(Departure(Time(hour: 21, minute: 41), services: [.car]).components(), [" 9:41.", "car", ""])
        XCTAssertEqual(Departure(Time(hour: 21, minute: 41), services: [.car]).components(empty: "&nbsp;"), [" 9:41.", "car", "&nbsp;"])
        XCTAssertEqual(Departure(Time(hour: 21, minute: 41), services: [.car]).components(empty: nil), [" 9:41.", "car"])
        XCTAssertEqual(Departure(Time(hour: 21, minute: 41)).components(), [" 9:41.", "", ""])
        XCTAssertEqual(Departure(Time(hour: 21, minute: 41)).components(empty: "_"), [" 9:41.", "_", "_"])
        XCTAssertEqual(Departure(Time(hour: 21, minute: 41)).components(empty: nil), [" 9:41."])
        DateFormatter.clockFormat = .system
    }
    
    // MARK: CustomStringConvertible
    func testDescription() {
        DateFormatter.clockFormat = .twelveHour
        XCTAssertEqual(Departure(Time(hour: 9, minute: 41), deviations: [.start(Date(timeIntervalSince1970: 1540958400.0)), .except(.sunday)]).description, " 9:41  starts 10/31; except Sun")
        XCTAssertEqual(Departure(Time(hour: 21, minute: 41), deviations: [.end(Date(timeIntervalSince1970: 1540958400.0))], services: [.car]).description, " 9:41. car ended 10/31")
        XCTAssertEqual(Departure(Time(hour: 21, minute: 41), services: [.car]).description, " 9:41. car")
        XCTAssertEqual(Departure(Time(hour: 21, minute: 41)).description, " 9:41.")
        DateFormatter.clockFormat = .system
    }
}

extension DepartureTests {
    
    // MARK: HTMLConvertible
    func testHTMLInit() throws {
        XCTAssertEqual(try Departure(from: "AM9:41 fso").time, Time(hour: 9, minute: 41))
        XCTAssertEqual(try Departure(from: "AM9:41 fso").deviations, [.only(.friday), .only(.saturday)])
        XCTAssertEqual(try Departure(from: "AM9:41 fso").services, [])
        XCTAssertEqual(try Departure(from: "AM9:41 cf xf").time, Time(hour: 9, minute: 41))
        XCTAssertEqual(try Departure(from: "AM9:41 cf xf").deviations, [.except(.friday)])
        XCTAssertEqual(try Departure(from: "AM9:41 cf xf").services, [.car])
        XCTAssertEqual(try Departure(from: "PM9:41").time, Time(hour: 21, minute: 41))
        XCTAssertEqual(try Departure(from: "PM9:41").deviations, [])
        XCTAssertEqual(try Departure(from: "PM9:41").services, [])
    }
}

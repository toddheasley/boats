import XCTest
@testable import Boats

class DepartureTests: XCTestCase {
    func testIsCarFerry() {
        XCTAssertTrue(Departure(Time(hour: 9, minute: 41), services: [.car]).isCarFerry)
        XCTAssertFalse(Departure(Time(hour: 9, minute: 41)).isCarFerry)
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
        XCTAssertEqual(try Departure(from: "AM9:41 ∆").time, Time(hour: 9, minute: 41))
        XCTAssertEqual(try Departure(from: "AM9:41 ∆").deviations, [.only(.monday), .only(.tuesday), .only(.wednesday), .only(.thursday), .only(.friday)])
        XCTAssertEqual(try Departure(from: "AM9:41 ∆").services, [])
        XCTAssertEqual(try Departure(from: "AM9:41 cf ⁕").time, Time(hour: 9, minute: 41))
        XCTAssertEqual(try Departure(from: "AM9:41 cf ⁕").deviations, [.only(.friday), .only(.saturday)])
        XCTAssertEqual(try Departure(from: "AM9:41 cf ⁕").services, [.car])
        XCTAssertEqual(try Departure(from: "PM9:41").time, Time(hour: 21, minute: 41))
        XCTAssertEqual(try Departure(from: "PM9:41").deviations, [])
        XCTAssertEqual(try Departure(from: "PM9:41").services, [])
    }
}

import XCTest
@testable import BoatsKit

class DepartureTests: XCTestCase {
    func testCarFerry() {
        XCTAssertTrue(Departure(time: Time(hour: 16, minute: 20), services: [.car]).isCarFerry)
        XCTAssertFalse(Departure(time: Time(hour: 16, minute: 20)).isCarFerry)
    }
}

extension DepartureTests {
    
    // MARK: CustomStringConvertible
    func testDescription() {
        DateFormatter.clockFormat = .twelveHour
        XCTAssertEqual(Departure(time: Time(hour: 16, minute: 20), services: [.car]).description, "4:20. cf")
        XCTAssertEqual(Departure(time: Time(hour: 16, minute: 20)).description, "4:20.")
        DateFormatter.clockFormat = .auto
    }
}

extension DepartureTests {
    
    // MARK: HTMLConvertible
    func testHTMLInit() {
        XCTAssertEqual(try? Departure(from: "AM4:20cf").time, Time(hour: 4, minute: 20))
        XCTAssertEqual(try? Departure(from: "AM4:20 cf ").services, [.car])
        XCTAssertEqual(try? Departure(from: " PM4:20").time, Time(hour: 16, minute: 20))
        XCTAssertEqual(try? Departure(from: "PM4:20").services, [])
    }
}

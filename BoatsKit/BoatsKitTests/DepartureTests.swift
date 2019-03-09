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
        XCTAssertEqual(Departure(time: Time(hour: 4, minute: 20), deviations: [.start(Date(timeIntervalSince1970: 1540958400.0)), .holiday]).description, "4:20 started 10/31, except holiday")
        XCTAssertEqual(Departure(time: Time(hour: 16, minute: 20), deviations: [.end(Date(timeIntervalSince1970: 1540958400.0))], services: [.car]).description, "4:20. ended 10/31, car")
        XCTAssertEqual(Departure(time: Time(hour: 16, minute: 20), services: [.car]).description, "4:20. car")
        XCTAssertEqual(Departure(time: Time(hour: 16, minute: 20)).description, "4:20.")
        DateFormatter.clockFormat = .auto
    }
}

extension DepartureTests {
    
    // MARK: HTMLConvertible
    func testHTMLInit() {
        XCTAssertEqual(try? Departure(from: "AM4:20 starts 4/20").time, Time(hour: 4, minute: 20))
        XCTAssertEqual(try? Departure(from: "AM4:20 starts 4/20").deviations.count, 1)
        XCTAssertEqual(try? Departure(from: "AM4:20 starts 4/20").services, [])
        XCTAssertEqual(try? Departure(from: "PM4:20 ends 10/31").time, Time(hour: 16, minute: 20))
        XCTAssertEqual(try? Departure(from: "PM4:20 ends 10/31").deviations.count, 1)
        XCTAssertEqual(try? Departure(from: "PM4:20 ends 10/31").services, [])
        XCTAssertEqual(try? Departure(from: "PM4:20 xh").time, Time(hour: 16, minute: 20))
        XCTAssertEqual(try? Departure(from: "PM4:20 xh").deviations, [.holiday])
        XCTAssertEqual(try? Departure(from: "PM4:20 xh").services, [])
        XCTAssertEqual(try? Departure(from: "AM4:20 cf").time, Time(hour: 4, minute: 20))
        XCTAssertEqual(try? Departure(from: "AM4:20 cf").deviations, [])
        XCTAssertEqual(try? Departure(from: "AM4:20 cf").services, [.car])
        XCTAssertEqual(try? Departure(from: "AM4:20").time, Time(hour: 4, minute: 20))
        XCTAssertEqual(try? Departure(from: "AM4:20").deviations, [])
        XCTAssertEqual(try? Departure(from: "AM4:20").services, [])
    }
}

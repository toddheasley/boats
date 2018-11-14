import XCTest
@testable import BoatsKit

class DateFormatterTests: XCTestCase {
    
}

extension DateFormatterTests {
    func testShared() {
        XCTAssertEqual(DateFormatter.shared.timeZone.identifier, "America/New_York")
    }
    
    func test24Hour() {
        XCTAssertFalse(DateFormatter.shared.is24Hour)
    }
    
    func testTime() {
        XCTAssertEqual(DateFormatter.shared.time(from: Date(timeIntervalSince1970: 1541303999.0)), Time(hour: 23, minute: 59))
        XCTAssertEqual(DateFormatter.shared.time(from: Date(timeIntervalSince1970: 1541304000.0)), Time(hour: 0, minute: 0))
        XCTAssertEqual(DateFormatter.shared.time(from: Date(timeIntervalSince1970: 1541316600.0)), Time(hour: 2, minute: 30))
    }
    
    func testTimeZoneInit() {
        XCTAssertEqual(DateFormatter(timeZone: TimeZone(identifier: "America/Los_Angeles")!).timeZone.identifier, "America/Los_Angeles")
        XCTAssertEqual(DateFormatter(timeZone: TimeZone(identifier: "America/New_York")!).timeZone.identifier, "America/New_York")
    }
}

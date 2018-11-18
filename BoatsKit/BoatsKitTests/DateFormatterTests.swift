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
    
    func testComponentsNext() {
        XCTAssertEqual(DateFormatter.shared.next(in: [(2018, 4, 20), (2019, 4, 20)], from: Date(timeIntervalSince1970: 1524196800.0)), Date(timeIntervalSince1970: 1524196800.0))
        XCTAssertEqual(DateFormatter.shared.next(in: [(2018, 4, 20), (2019, 4, 20)], from: Date(timeIntervalSince1970: 1524196801.0)), Date(timeIntervalSince1970: 1555732800.0))
        XCTAssertEqual(DateFormatter.shared.next(in: [(2018, 4, 20), (2019, 4, 20)], from: Date(timeIntervalSince1970: 1555732801.0)), Date(timeIntervalSince1970: 0.0))
        XCTAssertEqual(DateFormatter.shared.next(in: [], from: Date()), Date(timeIntervalSince1970: 0.0))
    }
    
    func testMonthDayNext() {
        XCTAssertEqual(DateFormatter.shared.next(month: 4, day: 20, from: Date()), DateFormatter.shared.next(month: 4, day: 20))
        XCTAssertEqual(DateFormatter.shared.next(month: 4, day: 20, from: Date(timeIntervalSince1970: 1555732800.0)), Date(timeIntervalSince1970: 1555732800.0))
        XCTAssertEqual(DateFormatter.shared.next(month: 4, day: 20, from: Date(timeIntervalSince1970: 1555732801.0)), Date(timeIntervalSince1970: 1587355200.0))
    }
    
    func testYear() {
        XCTAssertEqual(DateFormatter.shared.year(from: Date(timeIntervalSince1970: 1524196800.0)), 2018)
        XCTAssertEqual(DateFormatter.shared.year(from: Date(timeIntervalSince1970: 1587355200.0)), 2020)
    }
    
    func testTimeZoneInit() {
        XCTAssertEqual(DateFormatter(timeZone: TimeZone(identifier: "America/Los_Angeles")!).timeZone.identifier, "America/Los_Angeles")
        XCTAssertEqual(DateFormatter(timeZone: TimeZone(identifier: "America/New_York")!).timeZone.identifier, "America/New_York")
    }
}

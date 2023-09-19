import XCTest
@testable import Boats

class DateFormatterTests: XCTestCase {
    
}

extension DateFormatterTests {
    func testShared() {
        XCTAssertEqual(DateFormatter.shared.timeZone.identifier, "America/New_York")
    }
    
    func test24Hour() {
        XCTAssertFalse(DateFormatter.shared.is24Hour)
    }
    
    func testDateDescription() {
        XCTAssertEqual(DateFormatter.shared.description(from: Date(timeIntervalSince1970: 1523678400.0)), "Apr 14")
        XCTAssertEqual(DateFormatter.shared.description(from: Date(timeIntervalSince1970: 1536033600.0)), "Sep 4")
    }
    
    func testDateIntervalDescription() {
        XCTAssertEqual(DateFormatter.shared.description(from: DateInterval(start: Date(timeIntervalSince1970: 1523678400.0), end: Date(timeIntervalSince1970: 1529121599.9))), "Apr 14-Jun 15, 2018")
        XCTAssertEqual(DateFormatter.shared.description(from: DateInterval(start: Date(timeIntervalSince1970: 1529121600.0), end: Date(timeIntervalSince1970: 1536033599.9))), "Jun 16-Sep 3, 2018")
        XCTAssertEqual(DateFormatter.shared.description(from: DateInterval(start: Date(timeIntervalSince1970: 1536033600.0), end: Date(timeIntervalSince1970: 1539057599.9))), "Sep 4-Oct 8, 2018")
        XCTAssertEqual(DateFormatter.shared.description(from: DateInterval(start: Date(timeIntervalSince1970: 1539057600), end: Date(timeIntervalSince1970: 1546664399.9))), "Oct 9, 2018-Jan 4, 2019")
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
    
    func testDay() {
        XCTAssertEqual(DateFormatter.shared.day(from: Date(timeIntervalSince1970:  1524196800.0)), .friday)
        XCTAssertEqual(DateFormatter.shared.day(from: Date(timeIntervalSince1970:  1587355200.0)), .monday)
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

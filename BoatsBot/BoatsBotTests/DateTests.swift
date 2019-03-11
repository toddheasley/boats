import XCTest
import BoatsKit
@testable import BoatsBot

class DateTests: XCTestCase {
    
}

extension DateTests {
    func testDayTimeInit() {
        XCTAssertEqual(Date(day: .saturday, time: Time(hour: 23, minute: 30), matching: Date(timeIntervalSince1970: 1552192200.0)), Date(timeIntervalSince1970: 1552192200.0))
        XCTAssertEqual(Date(day: .sunday, time: Time(hour: 0, minute: 30), matching: Date(timeIntervalSince1970: 1552195800.0)), Date(timeIntervalSince1970: 1552195800.0))
        XCTAssertEqual(Date(day: .sunday, time: Time(hour: 4, minute: 0), matching: Date(timeIntervalSince1970: 1552204800.0)), Date(timeIntervalSince1970: 1552204800.0))
        XCTAssertEqual(Date(day: .sunday, time: Time(hour: 23, minute: 30), matching: Date(timeIntervalSince1970: 1552275000.0)), Date(timeIntervalSince1970: 1552275000.0))
        XCTAssertNil(Date(day: .monday, time: Time(hour: 23, minute: 30), matching: Date(timeIntervalSince1970: 1552275000.0)))
    }
}

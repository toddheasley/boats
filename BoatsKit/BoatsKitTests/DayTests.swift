import XCTest
@testable import BoatsKit

class DayTests: XCTestCase {
    
}

extension DayTests {
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(Day.monday.description, "Monday")
        XCTAssertEqual(Day.tuesday.description, "Tuesday")
        XCTAssertEqual(Day.wednesday.description, "Wednesday")
        XCTAssertEqual(Day.thursday.description, "Thursday")
        XCTAssertEqual(Day.friday.description, "Friday")
        XCTAssertEqual(Day.saturday.description, "Saturday")
        XCTAssertEqual(Day.sunday.description, "Sunday")
        XCTAssertEqual(Day.holiday.description, "Holiday")
    }
}

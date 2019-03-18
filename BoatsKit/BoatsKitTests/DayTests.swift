import XCTest
@testable import BoatsKit

class DayTests: XCTestCase {
    func testDateInit() {
        XCTAssertEqual(Day(date: Date(timeIntervalSince1970:  1524196800.0)), .friday)
        XCTAssertEqual(Day(date: Date(timeIntervalSince1970:  1587355200.0)), .monday)
    }
}

extension DayTests {
    func testAbbreviated() {
        XCTAssertEqual(Day.monday.abbreviated, "Mon")
        XCTAssertEqual(Day.tuesday.abbreviated, "Tue")
        XCTAssertEqual(Day.wednesday.abbreviated, "Wed")
        XCTAssertEqual(Day.thursday.abbreviated, "Thu")
        XCTAssertEqual(Day.friday.abbreviated, "Fri")
        XCTAssertEqual(Day.saturday.abbreviated, "Sat")
        XCTAssertEqual(Day.sunday.abbreviated, "Sun")
        XCTAssertEqual(Day.holiday.abbreviated, "Hol")
    }
    
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

extension DayTests {
    
    // MARK: HTMLConvertible
    func testHTMLInit() {
        XCTAssertEqual(try? Day(from: "Monday"), .monday)
        XCTAssertEqual(try? Day(from: "Tues."), .tuesday)
        XCTAssertEqual(try? Day(from: "Wed"), .wednesday)
        XCTAssertEqual(try? Day(from: "Thurs"), .thursday)
        XCTAssertEqual(try? Day(from: "Friday"), .friday)
        XCTAssertEqual(try? Day(from: "Sa."), .saturday)
        XCTAssertEqual(try? Day(from: "Su"), .sunday)
        XCTAssertEqual(try? Day(from: "Holidoy"), .holiday)
        XCTAssertNil(try? Day(from: "Day"))
        XCTAssertNil(try? Day(from: "S"))
    }
}
